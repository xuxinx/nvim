local utils = require("x.utils")

local M = {}

M.find_note = function()
    require("x.note").find_note()
end

M.grep_note = function()
    require("x.note").grep_note()
end

-- args
--   - path
M.z_local_jump = function(opts)
    require("x.z").z_navi("lcd", opts.args)
end

-- args
--   - path
M.z_global_jump = function(opts)
    require("x.z").z_navi("cd", opts.args)
end

M.open_git = function()
    require("x.open_git").open_git()
end

M.rename_var = function()
    vim.lsp.buf.rename()
end

M.debug_test = function()
    require("x.dap_go").debug_test()
end

M.toggle_debug_scopes = function()
    require("x.dap").scopes.toggle()
end

M.toggle_debug_repl = function()
    require("dap").repl.toggle()
end

M.save_session = function(opts)
    require("x.session").save_session(opts.args)
end

M.load_session = function()
    require("x.session").select_session_to_load()
end

M.delete_session = function()
    require("x.session").select_session_to_delete()
end

M.edit_project_config = function()
    require("x.project_config").edit()
end

M.create_test_file = function()
    local curr_fpath = vim.api.nvim_buf_get_name(0)
    local curr_fname = vim.fs.basename(curr_fpath)
    local ext = utils.get_filename_extension(curr_fname)
    local fname
    if ext == "go" then
        fname = utils.remove_filename_extension(curr_fname) .. "_test.go"
    else
        vim.notify("file type of " .. curr_fname .. " is not supported", vim.log.levels.WARN)
        return
    end
    vim.cmd("e " .. utils.join_path(vim.fs.dirname(curr_fpath), fname))
end

M.create_setup_test_file = function()
    local curr_fpath = vim.api.nvim_buf_get_name(0)
    local curr_fname = vim.fs.basename(curr_fpath)
    local ext = utils.get_filename_extension(curr_fname)
    local fname
    if ext == "go" then
        fname = "setup_test.go"
    else
        vim.notify("file type of " .. curr_fname .. " is not supported", vim.log.levels.WARN)
        return
    end
    vim.cmd("e " .. utils.join_path(vim.fs.dirname(curr_fpath), fname))
end

M.open_terminal_for_current_dir = function()
    require("x.terminal").open_terminal_for_current_dir()
end

M.execute_go_generate = function()
    require("x.go").execute_go_generate()
end

return M
