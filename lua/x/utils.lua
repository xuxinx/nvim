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

local function clamp(component)
  return math.min(math.max(component, 0), 255)
end

function M.lightenColor(col, amt)
  local num = tonumber(col:gsub("^#", ""), 16)
  local r = math.floor(num / 0x10000) + amt
  local g = (math.floor(num / 0x100) % 0x100) + amt
  local b = (num % 0x100) + amt
  return string.format("#%06x", clamp(r) * 0x10000 + clamp(g) * 0x100 + clamp(b))
end

return M
