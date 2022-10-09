require('plugins')
require('lsp')
require('onedark').load()

vim.wo.number = true
vim.g.mapleader = "<Space>"
vim.opt.tabstop=4

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- print test
vim.keymap.set('n', '<Space>ht', function()
  print("hello test")
end, {})

