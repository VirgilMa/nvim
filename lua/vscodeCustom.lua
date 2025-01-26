

if not vim.g.vscode then return end

local vscode = require('vscode')

function go_to_definition()
    -- You can use Neovim's built-in functionality or call external commands here
    -- For example, to use the built-in LSP for "go to definition"
    -- vim.lsp.buf.definition()
    vscode.call("editor.action.revealDefinition")
end

vim.api.nvim_set_keymap('n', 'gd', ':lua go_to_definition()<CR>', { noremap = true, silent = true })

-- useless
-- vim.api.nvim_set_keymap('v', '<C-c>', '<Cmd>call VSCodeCall("editor.action.clipboardCopyAction")<CR>', { noremap = true, silent = true })

