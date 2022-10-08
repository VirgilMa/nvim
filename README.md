# nvim

VirgilMa's neovim configuration

## Configuration Setup

1. Install [packer](https://github.com/wbthomason/packer.nvim)
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
2. Clone [VirgilMa/nvim](https://github.com/virgilma/nvim) into ~/.config
```bash
git clone git@github.com:VirgilMa/nvim.git ~/.config
```
3. Run nvim and run the following commands to install plugins:
```
:PackerInstall
```
4. Restart nvim and run `:CheckHealth`. Fix shown issues to complete the configuration.
