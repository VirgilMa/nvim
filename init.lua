-- need to be before all other map configurations
vim.g.mapleader = ";"
-- vim.g.mapleader = "<Space>"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.number = true
vim.opt.tabstop = 4
vim.o.ignorecase = true

-- print test
vim.keymap.set('n', '<Space>ht', function()
  print("hello test")
end, {})

require('plugins')
require('coc')
require('onedark').load()

