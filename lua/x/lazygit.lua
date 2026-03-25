local M = {}

local state = { buf = nil, win = nil }

local function create_float_win(buf)
    local ui_height = vim.o.lines - 2
    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(ui_height * 0.9)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((ui_height - height) / 2)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    })
    vim.wo[win].winhighlight = "Normal:Normal"
    return win
end

M.toggle = function()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        state.win = create_float_win(state.buf)
        vim.cmd("startinsert")
        return
    end

    state.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[state.buf].bufhidden = "hide"
    state.win = create_float_win(state.buf)

    vim.fn.termopen("lazygit", {
        on_exit = function()
            if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
                vim.api.nvim_buf_delete(state.buf, { force = true })
            end
            state.buf = nil
            state.win = nil
        end,
    })

    vim.cmd("startinsert")
    vim.api.nvim_buf_set_keymap(state.buf, "t", "<C-[>", "<C-[>", { noremap = true, nowait = true })
    vim.api.nvim_buf_set_keymap(state.buf, "t", "<bslash>g", "", { noremap = true, silent = true, callback = M.toggle })
end

return M
