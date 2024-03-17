local util = require("x.utils")

local M = {}

M.open_git = function()
    local handle = assert(io.popen([[git config --get remote.origin.url]]))
    local repo_url = handle:read("*a")
    handle:close()
    repo_url = string.gsub(repo_url, [[git@github.com:]], "https://github.com/")
    repo_url = string.gsub(repo_url, "%.git", "")
    repo_url = string.gsub(repo_url, "\n", "")

    handle = assert(io.popen([[git branch | grep "\*" | cut -d " " -f2]]))
    local branch = handle:read("*a")
    handle:close()
    branch = string.gsub(branch, "\n", "")

    handle = assert(io.popen([[git rev-parse --show-prefix]]))
    local path = handle:read("*a")
    handle:close()
    path = string.gsub(path, "\n", "")

    local url = repo_url .. "/blob/" .. branch .. "/" .. path .. vim.fn.expand("%:p:~:.") .. "#L" .. vim.fn.line(".")

    os.execute("open -a 'Google Chrome' " .. url)
end

M.open_finder = function()
    local path
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name:find("oil://", 1, true) then
        path = util.trim_prefix(buf_name, "oil://")
    else
        path = vim.fs.dirname(buf_name)
    end

    os.execute("open " .. path)
end

return M
