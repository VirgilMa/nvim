-- need to be before all other map configurations
vim.g.mapleader = ";"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.number = true
vim.o.ignorecase = true

-- tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- exit terminal 
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', {})
vim.keymap.set('t', '<c-[>', '<C-\\><C-n>', {})

-- print test
vim.keymap.set('n', '<Space>ht', function()
    print("hello test")
end, {})

require('plugins')
require('coc')
require('onedark').load()
