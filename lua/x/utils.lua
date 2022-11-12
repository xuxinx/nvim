local M = {}

function M.curr_dir()
    return vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
end

function M.base_cwd()
    return vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
end

function M.curr_file_path()
    return vim.fn.expand('%:p:~:.')
end

local function clamp(component)
    return math.min(math.max(component, 0), 255)
end

function M.lighten_color(col, amt)
    local num = tonumber(col:gsub("^#", ""), 16)
    local r = math.floor(num / 0x10000) + amt
    local g = (math.floor(num / 0x100) % 0x100) + amt
    local b = (num % 0x100) + amt
    return string.format("#%06x", clamp(r) * 0x10000 + clamp(g) * 0x100 + clamp(b))
end

-- http://www.lua.org/pil/11.5.html
function M.set(list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set
end

return M
