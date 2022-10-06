
require('plugins')
require('lsp')
require('onedark').load()

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gf', builtin.find_files, {})
vim.keymap.set('n', 'g/', builtin.live_grep, {})
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
vim.keymap.set('n', 'gh', builtin.help_tags, {})
vim.keymap.set('n', '<A-v>', '<C-v>', {})

vim.wo.number = true
vim.g.mapleader = "<Space>"

-- print test
vim.keymap.set('n', '<Space>ht', function()
	print("hello test")
end, {})

