
require('plugins')
require('lsp')
require('onedark').load()

vim.wo.number = true
vim.g.mapleader = "<Space>"

-- print test
vim.keymap.set('n', '<Space>ht', function()
  print("hello test")
end, {})

