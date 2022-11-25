<div align="center">
  <h1>Neovim configuration</h1>
  <blockquote align="center">
    A minimal Neovim configuration written in lua
  </blockquote>
  <p>
    <a href="https://github.com/ntk148v/neovim-config/blob/master/LICENSE">
      <img
        alt="GitHub license"
        src="https://img.shields.io/github/license/ntk148v/neovim-config?style=for-the-badge"
      />
    </a>
    <a href="https://github.com/ntk148v/neovim-config/stargazers">
      <img
        alt="GitHub stars"
        src="https://img.shields.io/github/stars/ntk148v/neovim-config?style=for-the-badge"
      />
    </a>
  </p>
  <br />
</div>

Table of contents

- [1. Introduction](#1-introduction)
- [2. Installation](#2-installation)
- [3. Configuration](#3-configuration)
- [4. Plugins \& LSP](#4-plugins--lsp)
  - [4.1. Plugins](#41-plugins)
  - [4.2. LSP](#42-lsp)
- [5. Keymaps](#5-keymaps)
- [6. Screenshots](#6-screenshots)
- [7. Contribution](#7-contribution)
- [8. Guide and resources](#8-guide-and-resources)

## 1. Introduction

[Neovim](https://neovim.io/) is a pretty cool successor to Vim, focusing on compatibility while adding asynchronous plugin functionality and trying to clean up the code base. Having been fed up at various times with both Sublime Text (2 and 3) and Atom, and after realizing how much development I do over SSH, it seemed reasonable to check out using vim (or nvim, in this case) as my IDE. The advantages essentially boil down to:

- Consistent IDE over SSH or locally,
- No need to ever use the mouse while coding (takes longer to learn, but is faster; this is aided by vim-easymotion and Ctrl-Space),
- It’s been around forever, and frankly, probably always will be.

Therefore, I decided to create this repository. There are several versions:
- [v0.1.0](): written in VimL, a single file only.
- [v0.1.1](): written in VimL, consist of mutliple files.
- [v0.2.0](): started this version, switch from VimL to Lua. For the reason, you may to check [neovim's official wiki](https://github.com/neovim/neovim/wiki/FAQ#why-embed-lua-instead-of-x). Follow [KISS principle](https://en.wikipedia.org/wiki/KISS_principle), this version uses the least plugins as possible. It's more like a skeleton, users can add more plugins and LSP.

## 2. Installation

- Requirements:
  - [neovim >= 0.7.0](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package)
  - git
  - [nerdfonts](https://www.nerdfonts.com/font-downloads)
- Backup your current neovim config, if necessary:

```shell
mv ~/.config/nvim ~/.config/nvim.bak
```

- Get your configuration:

```shell
git clone https://github.com/ntk148v/neovim-config.git
cd neovim-config.git/
cp -Rv nvim ~/.config/
```

- Start Neovim, Packer should be installed automatically, then run the following command to install plugins:

```vim
:PackerSync
```

## 3. Configuration

## 4. Plugins & LSP

### 4.1. Plugins

| Plugin                                                                            | Description                                                                                                                                                       |
| --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [packer.nvim](https://github.com/wbthomason/packer.nvim)                          | A use-package inspired plugin manager for Neovim                                                                                                                  |
| [mason.nvim](https://github.com/williamboman/mason.nvim)                          | Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.                |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                        | A collection of common configurations for Neovim's built-in language server client                                                                                |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim)                            | Super fast git decorations implemented purely in lua/teal                                                                                                         |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)             | Nvim Treesitter configurations and abstraction layer                                                                                                              |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                   | Auto completion plugin                                                                                                                                            |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                    | Snippet Engine for Neovim written in Lua                                                                                                                          |
| [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) -                    | A File Explorer written In Lua                                                                                                                                    |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                        | A super powerful autopairs for Neovim                                                                                                                             |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)               | Lua `fork` of vim-web-devicons for neovim                                                                                                                         |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                      | A blazing fast and easy to configure neovim statusline plugin written in pure lua.                                                                                |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim)                          | Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more                                        |
| [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)     | The fastest Neovim colorizer.                                                                                                                                     |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Find, Filter, Preview, Pick. All lua, all the time.                                                                                                               |
| [itmecho/neoterm.nvim](https://github.com/itmecho/neoterm.nvim)                   | Neovim lua plugin for managing a floating terminal window                                                                                                         |
| [rosé-pine](https://github.com/rose-pine/neovim)                                  | Soho vibes for Neovim                                                                                                                                             |
| [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                 | A clean, dark Neovim theme written in Lua, with support for lsp, treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish. |
| [projekt0n/github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)     | Github's Neovim themes                                                                                                                                            |

### 4.2. LSP

This configuration provides Python and Golang dev environment. The programming language server is current supported:

- lua - [builtin](https://neovim.io/doc/user/lua.html).
- python - [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
- golang - [gopls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls)
- docker - [dockerls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls)
- bash - [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls)

Furthermore, it integrates with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to provide rich syntax highlighting and other language parsing magic.

If your language is not supported, please follow this:

- Check if LSP support is avaiable in the [lspconfig repo](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md). To install a supported language server with [mason](https://github.com/williamboman/mason.nvim):

```vim
:LspInstall `<your_language_server>`
```

- Check if your syntax is supported in the [treesitter repo](https://github.com/nvim-treesitter/nvim-treesitter). To install a language syntax hightlight, run:

```vim
:TSInstall `<language_to_install>`
```

## 5. Keymaps

These are the default keymaps, in the following shortcuts, the `<leader>` key is set up to ` ` (space) character, check: [keymaps.lua](./nvim/lua/core/keymaps.lua).

| Shortcut           | Mode     | Description                                   |
| ------------------ | -------- | --------------------------------------------- |
| `kk`               | Insert   | Esc with `kk`                                 |
| `<leader>r`        | Normal   | Reload configuration file                     |
| `<leader>s`        | Normal   | Save file                                     |
| `<leader>q`        | Normal   | Save (close all windows) and exit from Neovim |
| `<leader>tt`       | Normal   | Open floating terminal                        |
| `<Esc>`            | Terminal | Exit terminal                                 |
| `<Ctrl> + n`       | Normal   | Open NvimTree                                 |
| `<leader>f`        | Normal   | Refresh NvimTree                              |
| `<leader>n`        | Normal   | Find file in NvimTree                         |
| `<leader>ff`       | Normal   | Open Telescope to find files                  |
| `<leader>fg`       | Normal   | Open Telescope to do live grep                |
| `<leader>fb`       | Normal   | Open Telescope to list buffers                |
| `<leader>fh`       | Normal   | Open Telescope to show help                   |
| `<leader>wh/j/k/l` | Normal   | Move around splits                            |
| `gcc`              | Normal   | Comment/Uncomment line                        |
| `gbc`              | Normal   | Comment/Uncomment block                       |

## 6. Screenshots

## 7. Contribution

## 8. Guide and resources

- [nanotee/nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide)
- [brainfucksec/neovim-lua](https://github.com/brainfucksec/neovim-lua)
- [LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)
