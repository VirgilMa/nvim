-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.keymap.set('n', '<Space>hl', ':TSEnable highlight<CR>', {})
vim.keymap.set('n', 'gn', ':bn<CR>', {})
vim.keymap.set('n', 'gp', ':bp<CR>', {})
vim.keymap.set('n', '<A-o>', ':e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>', {})

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'navarasu/onedark.nvim' -- onedark theme
    use 'kyazdani42/nvim-web-devicons'

    -- coc
    use { 'neoclide/coc.nvim', branch = 'release' }

    -- tree-sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            local tree = require('nvim-treesitter')
            tree.setup {
                ensure_installed = { "c", "python", "cpp", "rust", "lua" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            }
        end
    }

    -- comment helper
    -- `gcc/gbc` for normal mode and `gc/gb` for visual mode
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'BurntSushi/ripgrep' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            -- {'kyazdani42/nvim-web-devicons'}
        },
        config = function()
            -- telescope
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<Space>f', builtin.find_files, {})
            -- vim.keymap.set('n', 'g/', builtin.live_grep, {})
            vim.keymap.set('n', '<Space>.', builtin.grep_string, {})
            vim.keymap.set('n', '<Space>j', builtin.jumplist, {})
            vim.keymap.set('n', '<Space>b', builtin.buffers, {})
            vim.keymap.set('n', '<Space>r', builtin.registers, {})
            vim.keymap.set('n', '<Space>g', builtin.git_status, {})
            vim.keymap.set('n', '<Space>t', ':Telescope<CR>', {})
            vim.keymap.set('n', '<Space>h', builtin.help_tags, {})
            vim.keymap.set('n', '<A-v>', '<C-v>', {})
            require("telescope").load_extension("live_grep_args")
            vim.keymap.set("n", "<Sapce>/", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        end
    }
    use 'nvim-telescope/telescope-symbols.nvim'

    -- git
    use 'tpope/vim-fugitive'
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
            local gs = package.loaded.gitsigns

            -- key map for git
            local function map(mode, l, r, opts)
                opts = opts or {}
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            local function next_hunk()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end

            local function prev_hunk()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end

            map('n', '<C-j>', next_hunk, { expr = true })
            map('n', ']c', next_hunk, { expr = true })
            map('n', '<C-k>', prev_hunk, { expr = true })
            map('n', '[c', prev_hunk, { expr = true })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function() gs.blame_line { full = true } end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
    use { 'APZelos/blamer.nvim', config = function() vim.g.blamer_enabled = true end }

    use { 'mhinz/vim-startify',
        config = function()
            vim.g.startify_custom_header =
            {
                '',
                '    ⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕',
                '    ⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕',
                '    ⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕',
                '    ⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕',
                '    ⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑',
                '    ⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐',
                '    ⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐',
                '    ⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔',
                '    ⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕',
                '    ⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕',
                '    ⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕',
                '    ⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕',
                '    ⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁',
                '    ⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿',
                '',
            }
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            -- 'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly', -- optional, updated every week. (see issue #1193)
        config = function()
            -- empty setup using defaults
            require("nvim-tree").setup()
            vim.keymap.set('n', '<c-t>', ':NvimTreeFindFileToggle<CR>', {})
        end
    }

    -- TODO: learn usage
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup()
        end
    })

    use { 'nvim-lualine/lualine.nvim', config = function() require('lualine').setup() end }
    use { 'akinsho/bufferline.nvim', tag = "v2.*", config = function() require('bufferline').setup() end }
    use { 'voldikss/vim-translator' }

end)
