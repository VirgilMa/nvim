local in_vscode = vim.g.vscode ~= nil

local ret = {
    "cqp/rua/rua.nvim",
    name = "rua",
    url = "ssh://git@gitlab.leihuo.netease.com:32200/cqp/rua/rua.nvim.git",
    dependencies = {"neovim/nvim-lspconfig"},
    cond = not in_vscode,
    config = function()
        require("rua").setup({
            loglevel = "ERROR",
            lsp = {
                project = "l36",
            },
        })
    end,
}

return {}

