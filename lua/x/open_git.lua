local M = {}

function M.openGit()
    local handle = io.popen[[git config --get remote.origin.url]]
    local repoURL = handle:read('*a')
    handle:close()
    repoURL = string.gsub(repoURL, [[git@github.com:]], 'https://github.com/')
    repoURL = string.gsub(repoURL, '%.git', '')
    repoURL = string.gsub(repoURL, '\n', '')

    handle = io.popen[[git branch | grep "\*" | cut -d " " -f2]]
    local branch = handle:read('*a')
    handle:close()
    branch = string.gsub(branch, '\n', '')

    handle = io.popen[[git rev-parse --show-prefix]]
    local path = handle:read('*a')
    handle:close()
    path = string.gsub(path, '\n', '')

    local url = repoURL .. '/blob/' .. branch .. '/' .. path .. vim.fn.expand('%:p:~:.') .. '#L' .. vim.fn.line('.')

    os.execute('open -a "Google Chrome" ' .. url)
end

return M
