local in_vscode = vim.g.vscode ~= nil

local ret = {
    -- 语法高亮
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cond = not in_vscode,
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require("nvim-treesitter").setup(
                {
                    ensure_installed = {
                        "lua", "python", "javascript", "html", "css", "cpp", "rust",
                    },
                    highlight = {enable = true},
                    indent = {enable = true},
                }
            )
        end,
    },
    {
        -- 自动补全
        "hrsh7th/nvim-cmp",
        cond = not in_vscode,
        event = "InsertEnter",
        dependencies = {"hrsh7th/cmp-nvim-lsp"},
        config = function()
            local cmp = require("cmp")
            cmp.setup(
                {
                    mapping = cmp.mapping.preset.insert(
                        {
                            ["<CR>"] = cmp.mapping.confirm({select = true}),
                            ["<Tab>"] = cmp.mapping.select_next_item(),
                        }
                    ),
                    sources = {{name = "nvim_lsp"}},
                }
            )
        end,
    },
    {
        -- 模糊查找
        "nvim-telescope/telescope.nvim",
        cond = not in_vscode,
        dependencies = {"nvim-lua/plenary.nvim"},
        cmd = "Telescope",
        keys = {
            {"<leader>ff", "<cmd>Telescope find_files<cr>"},
            {"<leader>fg", "<cmd>Telescope live_grep<cr>"},
        },
    }, -- tree
    {
        "kyazdani42/nvim-tree.lua",
        cond = not in_vscode,
        dependencies = {"nvim-tree/nvim-web-devicons"}, -- 图标
        keys = {
            {"<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "切换文件树"},
        },
        config = function()
            require("nvim-tree").setup(
                {
                    hijack_netrw = true, -- 替代默认 netrw
                    view = {width = 30},
                    git = {enable = true},
                }
            )
        end,
    },
    {
        "stevearc/conform.nvim",
        cond = not in_vscode,
        event = {"BufReadPre", "BufNewFile"},
        config = function()
            local conform = require("conform")

            conform.setup(
                {
                    formatters_by_ft = {
                        lua = {"stylua"},
                        rust = {"rustfmt"},
                        c = {"clang_format"},
                        cpp = {"clang_format"},
                        python = {"black"},
                        javascript = {"prettier"},
                        typescript = {"prettier"},
                        markdown = {"prettier"},
                    }, -- ✅ 关闭 保存自动格式化
                    -- format_on_save = {
                    --   timeout_ms = 500,
                    --   lsp_fallback = true
                    -- },
                }
            )

            -- ✅ 全局快捷键：
            -- 正常模式：格式化整个文件
            -- 可视化模式：格式化选中区域
            vim.keymap.set(
                {"n", "v"}, "<A-S-F>", function()
                    conform.format(
                        {
                            timeout_ms = 1000,
                            lsp_fallback = true,
                        }
                    )
                end, {desc = "格式化文件/选中区域"}
            )
        end,
    },
    {
        -- 包围符号操作：cs"' / ds( / ysiw]
        "kylechui/nvim-surround",
        version = "*",
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require("nvim-surround").setup({})
        end,
    },
}
return ret
