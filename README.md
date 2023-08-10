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
    <img
      alt="Neovim version"
      src="https://img.shields.io/badge/Neovim-0.8+-57A143?style=for-the-badge&logo=neovim"
    />
  </p>
  <br />
</div>

Table of contents

- [1. Introduction](#1-introduction)
- [2. Installation](#2-installation)
- [3. File structure](#3-file-structure)
- [4. Plugins \& LSP](#4-plugins--lsp)
  - [4.1. Plugins](#41-plugins)
  - [4.2. LSP](#42-lsp)
- [5. Keymaps](#5-keymaps)
- [6. Customization](#6-customization)
- [7. Screenshots](#7-screenshots)
- [8. Contribution](#8-contribution)
- [9. Guide and resources](#9-guide-and-resources)

## 1. Introduction

[Neovim](https://neovim.io/) is a pretty cool successor to Vim, focusing on compatibility while adding asynchronous plugin functionality and trying to clean up the code base. Having been fed up at various times with both Sublime Text (2 and 3) and Atom, and after realizing how much development I do over SSH, it seemed reasonable to check out using vim (or nvim, in this case) as my IDE. The advantages essentially boil down to:

- Consistent IDE over SSH or locally,
- No need to ever use the mouse while coding (takes longer to learn, but is faster; this is aided by vim-easymotion and Ctrl-Space),
- It’s been around forever, and frankly, probably always will be.

Therefore, I decided to create this repository. There are several versions:

- [v0.1.0](https://github.com/ntk148v/neovim-config/tree/v0.1.0): written in VimL, a single file only.
- [v0.1.1](https://github.com/ntk148v/neovim-config/tree/v0.1.1): written in VimL, consist of mutliple files.
- [v0.2.0](https://github.com/ntk148v/neovim-config/tree/v0.2.0): started from this version, switch from VimL to Lua. For the reason, you may to check [neovim's official wiki](https://github.com/neovim/neovim/wiki/FAQ#why-embed-lua-instead-of-x). Follow [KISS principle](https://en.wikipedia.org/wiki/KISS_principle), this version uses the least plugins as possible. It's more like a skeleton, users can add more plugins and LSP.
- [v0.2.1](https://github.com/ntk148v/neovim-config/tree/v0.2.1): this version contains some minor changes.
- [v0.3.0](https://github.com/ntk148v/neovim-config/tree/v0.3.0): I decide to switch to [lazy.nvim](https://github.com/folke/lazy.nvim) as my plugin manager, instead of [packer](https://github.com/wbthomason/packer.nvim). The main reason is [lazy.nvim's support for plugin structure](https://github.com/folke/lazy.nvim#-structuring-your-plugins).

As I mentioned, this config is meant as a starting point, it is not a complete Neovim/Vim config distribution, if you're looking for a one, check out [here](https://github.com/rockerBOO/awesome-neovim#preconfigured-configuration).

## 2. Installation

- Requirements:
  - Install [neovim >= 0.8.0](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package), or you can [build it](https://github.com/neovim/neovim/wiki/Building-Neovim#) yourself.
  - git >= 2.19.0 (for partial clones suppot)
  - I recommend using a [nerdfonts](https://www.nerdfonts.com/font-downloads) (optional)
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

- Start Neovim, Lazy should be installed automatically, then it will install plugins.

## 3. File structure

The files under config will be automatically loaded at the appropriate time, so you don't need to require those files manually.

```shell
tree ~/.config/nvim
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   ├── autocmds.lua
    │   ├── custom
    │   │   └── init.lua
    │   ├── init.lua
    │   ├── keymaps.lua
    │   └── options.lua
    └── plugins
        ├── autopairs.lua
        ├── colorizer.lua
        ├── colorscheme.lua
        ├── comment.lua
        ├── custom
        │   ├── colorscheme.lua
        │   └── lush.lua
        ├── gitsigns.lua
        ├── lsp.lua
        ├── lualine.lua
        ├── neoterm.lua
        ├── telescope.lua
        ├── tree.lua
        └── treesitter.lua
```

## 4. Plugins & LSP

### 4.1. Plugins

| Plugin                                                                            | Description                                                                                                                                                       |
| --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                                   | A modern plugin manager for Neovim                                                                                                                                |
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
| [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim)                     | Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.                                                                        |

### 4.2. LSP

This configuration provides Python and Golang dev environment. The programming language server is current supported:

- lua - [builtin](https://neovim.io/doc/user/lua.html).
- python - [ruff_lsp](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp)
- golang - [gopls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls)
- docker - [dockerls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls)
- bash - [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls)
- vim - [vimls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls)
- yaml - [yamlls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls)
- json - [jsonls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls)

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

These are the default keymaps, in the following shortcuts, the `<leader>`+` key is set up to `` (space) character, check: [keymaps.lua](./nvim/lua/core/keymaps.lua).

| Shortcut                       | Mode     | Description                                   |
| ------------------------------ | -------- | --------------------------------------------- |
| <kbd>kk</kbd>                  | Insert   | Esc with `kk`                                 |
| `<leader>`+<kbd>r</kbd>        | Normal   | Reload configuration file                     |
| `<leader>`+<kbd>s</kbd>        | Normal   | Save file                                     |
| `<leader>`+<kbd>q</kbd>        | Normal   | Save (close all windows) and exit from Neovim |
| `<leader>`+<kbd>tt</kbd>       | Normal   | Open floating terminal                        |
| <kbd>Esc<kbd>                  | Terminal | Exit terminal                                 |
| `<leader>`+<kbd>n</kbd>        | Normal   | Open NvimTree                                 |
| `<leader>`+<kbd>nr</kbd>       | Normal   | Refresh NvimTree                              |
| `<leader>`+<kbd>nf</kbd>       | Normal   | Find file in NvimTree                         |
| `<leader>`+<kbd>ff</kbd>       | Normal   | Open Telescope to find files                  |
| `<leader>`+<kbd>fg</kbd>       | Normal   | Open Telescope to do live grep                |
| `<leader>`+<kbd>fb</kbd>       | Normal   | Open Telescope to list buffers                |
| `<leader>`+<kbd>fh</kbd>       | Normal   | Open Telescope to show help                   |
| `<leader>`+<kbd>wh/j/k/l</kbd> | Normal   | Move around splits                            |
| <kbd>mm</kbd>                  | Normal   | Comment/Uncomment line                        |
| <kbd>mbm</kbd>                 | Normal   | Comment/Uncomment block                       |
| <kbd>m</kbd>                   | Visual   | Comment/Uncomment line                        |
| <kbd>mb</kbd>                  | Visual   | Comment/Uncomment block                       |

There are many default keymaps, you can check it using `:map` command. There are also other variants:

- `:nmap` for normal mode mappings
- `:vmap` for visual mode mappings
- `:imap` for insert mode mappings

The above list is not complete. Typing `:help map` in Vim will give you more info.

## 6. Customization

- You can add your custom plugin specs under `lua/plugins/custom`. All files will be automatically loaded by `lazy.nvim`.
- You can also add your custom keymaps/options under `lua/config/custom`.

## 7. Screenshots

|                                                                        |                                                                        |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| <img src="screenshots/nvim1.png" alt="dark" style="border-radius:1%"/> | <img src="screenshots/nvim2.png" alt="dark" style="border-radius:1%"/> |
| <img src="screenshots/nvim3.png" alt="dark" style="border-radius:1%"/> | <img src="screenshots/nvim4.png" alt="dark" style="border-radius:1%"/> |
| <img src="screenshots/nvim5.png" alt="dark" style="border-radius:1%"/> | <img src="screenshots/nvim6.png" alt="dark" style="border-radius:1%"/> |

## 8. Contribution

Feel free to file an issue or open a pull request. You're welcome!

## 9. Guide and resources

- [nanotee/nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide)
- [brainfucksec/neovim-lua](https://github.com/brainfucksec/neovim-lua)
- [LunarVim/Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)
- [LunarVim/nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide)
