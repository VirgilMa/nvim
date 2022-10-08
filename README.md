# nvim

VirgilMa's neovim configuration

## Configuration Setup

1. Clone VirgilMa/nvim into ~/.config
```bash
git clone https://github.com/virgilma/nvim ~/.config
```
2. Install [packer](https://github.com/wbthomason/packer.nvim)
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
3. Run nvim and run the following commands to install plugins:
```
:PackerInstall
```
4. Restart nvim and run `:CheckHealth`. Fix shown issues to complete the configuration.
