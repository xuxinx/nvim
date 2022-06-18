local M = {}

function M.zNavi(cd, args)
    local handle = io.popen('zsh -c \'source $HOME/.oh-my-zsh/plugins/z.lua/z.lua.plugin.zsh && _zlua ' .. args .. ' > /dev/null && pwd\'')
    local path = handle:read('*a')
    handle:close()
    path = string.gsub(path, '\n', '')
    -- TODO: escape space
    vim.cmd(cd .. ' ' .. path)
end

return M
