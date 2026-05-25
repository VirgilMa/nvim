# nvim

VirgilMa's neovim configuration.

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager (auto-bootstrapped on first launch). Compatible with both standalone Neovim and the VSCode Neovim extension.

## Setup

1. Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) (>= 0.9 recommended).

2. Clone this repo into your Neovim config directory:

    ```bash
    # Linux / macOS
    git clone git@github.com:VirgilMa/nvim.git ~/.config/nvim

    # Windows (PowerShell)
    git clone git@github.com:VirgilMa/nvim.git $env:LOCALAPPDATA\nvim
    ```

3. Launch `nvim`. lazy.nvim will bootstrap itself and install all plugins automatically on first start.

4. Run `:checkhealth` to surface any remaining issues (e.g. missing tree-sitter compilers, formatters).

## Keymaps

- Leader: `<Space>` (local leader: `\`)

| Key            | Action              |
| -------------- | ------------------- |
| `<leader>ff`   | Telescope find files |
| `<leader>fg`   | Telescope live grep  |
| `<leader>e`    | Toggle nvim-tree     |
| `<A-S-F>`      | Format file / region (conform.nvim) |
| `<esc>` / `<C-[>` | Exit terminal mode |

## Plugins

| Plugin            | Purpose                       | VSCode |
| ----------------- | ----------------------------- | ------ |
| nvim-treesitter   | Syntax highlight / indent     | off    |
| nvim-cmp          | Autocomplete                  | off    |
| telescope.nvim    | Fuzzy finder                  | off    |
| nvim-tree.lua     | File explorer                 | off    |
| conform.nvim      | Formatter (stylua/clang-format/black/prettier/...) | off |
| nvim-surround     | Add / change / delete pairs   | on     |

Plugins gated by `cond = not in_vscode` are skipped when running inside VSCode Neovim — VSCode's native equivalents are used instead. `nvim-surround` is pure text manipulation and loads in both environments.

## Lockfile

`lazy-lock.json` is committed on purpose — it pins every plugin to a specific commit so installs are reproducible across machines. To upgrade plugins, run `:Lazy update` and commit the new lockfile.
