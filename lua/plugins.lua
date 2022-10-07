-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'navarasu/onedark.nvim' -- onedark theme

  -- complete
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- tree-sitter
  use { 'nvim-treesitter/nvim-treesitter' }

  -- comment helper
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- indent
  use "lukas-reineke/indent-blankline.nvim"

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'BurntSushi/ripgrep'},
      {'kyazdani42/nvim-web-devicons'}
    }
  }

  use 'nvim-telescope/telescope-symbols.nvim'

  -- git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {'glepnir/dashboard-nvim'}

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
     -- 'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

end)


-- key map for git
require('gitsigns').setup()
local gs = package.loaded.gitsigns

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Navigation
map('n', ']c', function()
  if vim.wo.diff then return ']c' end
  vim.schedule(function() gs.next_hunk() end)
  return '<Ignore>'
end, {expr=true})

map('n', '[c', function()
  if vim.wo.diff then return '[c' end
  vim.schedule(function() gs.prev_hunk() end)
  return '<Ignore>'
end, {expr=true})

-- Actions
map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>hS', gs.stage_buffer)
map('n', '<leader>hu', gs.undo_stage_hunk)
map('n', '<leader>hR', gs.reset_buffer)
map('n', '<leader>hp', gs.preview_hunk)
map('n', '<leader>hb', function() gs.blame_line{full=true} end)
map('n', '<leader>tb', gs.toggle_current_line_blame)
map('n', '<leader>hd', gs.diffthis)
map('n', '<leader>hD', function() gs.diffthis('~') end)
map('n', '<leader>td', gs.toggle_deleted)

-- Text object
map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')


require('nvim-treesitter').setup()

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


-- empty setup using defaults
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = false,	
        folder = false,	
        folder_arrow = false,	
        -- git = false,	
      },
    },
  },
})

vim.keymap.set('n', '<c-t>', ':NvimTreeFindFileToggle<CR>', {})


-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gf', builtin.find_files, {})
vim.keymap.set('n', 'g/', builtin.live_grep, {})
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
vim.keymap.set('n', '<Space>r', builtin.registers, {})
vim.keymap.set('n', '<Space>g', builtin.git_status, {})
vim.keymap.set('n', '<Space>t', ':Telescope<CR>t ', {})
vim.keymap.set('n', 'gh', builtin.help_tags, {})
vim.keymap.set('n', '<A-v>', '<C-v>', {})


-- dashboard
local db = require('dashboard')


db.custom_header = {
    '',
    '⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕',
    '⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕',
    '⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕',
    '⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕',
    '⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑',
    '⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐',
    '⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐',
    '⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔',
    '⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕',
    '⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕',
    '⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕',
    '⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕',
    '⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁',
    '⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿',
    '',
    }


db.custom_center = {
  {
    desc = 'Recently latest session (TODO)      ',
    shortcut = 'SPC s l',
    action ='SessionLoad'
  },
}


-- indent
require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
}


