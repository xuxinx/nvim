local M = {}

function M.open_git()
    local handle = io.popen([[git config --get remote.origin.url]])
    local repo_url = handle:read('*a')
    handle:close()
    repo_url = string.gsub(repo_url, [[git@github.com:]], 'https://github.com/')
    repo_url = string.gsub(repo_url, '%.git', '')
    repo_url = string.gsub(repo_url, '\n', '')

    handle = io.popen([[git branch | grep "\*" | cut -d " " -f2]])
    local branch = handle:read('*a')
    handle:close()
    branch = string.gsub(branch, '\n', '')

    handle = io.popen([[git rev-parse --show-prefix]])
    local path = handle:read('*a')
    handle:close()
    path = string.gsub(path, '\n', '')

    local url = repo_url .. '/blob/' .. branch .. '/' .. path .. vim.fn.expand('%:p:~:.') .. '#L' .. vim.fn.line('.')

    os.execute('open -a "Google Chrome" ' .. url)
end

return M
