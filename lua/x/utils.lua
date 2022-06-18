local M = {}

function M.currDir()
    return vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
end

function M.baseCwd()
    return vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
end

function M.currFilePath()
    return vim.fn.expand('%:p:~:.')
end

-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function M.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

return M
