require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/snippets' })
