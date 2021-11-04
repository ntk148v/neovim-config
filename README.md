# Neovim-config

- [Neovim-config](#neovim-config)
  - [1. Using NeoVim as an Python+Golang IDE](#1-using-neovim-as-an-pythongolang-ide)
  - [2. Requirements](#2-requirements)
  - [3. Installation](#3-installation)
  - [4. Plugins](#4-plugins)
  - [5. Screenshot](#5-screenshot)

## 1. Using NeoVim as an Python+Golang IDE

[Neovim](https://neovim.io/) is a pretty cool successor to Vim, focusing on compatibility while adding asynchronous plugin functionality and trying to clean up the code base. Having been fed up at various times with both Sublime Text (2 and 3) and Atom, and after realizing how much development I do over SSH, it seemed reasonable to check out using vim (or nvim, in this case) as my IDE. The advantages essentially boil down to:

- Consistent IDE over SSH or locally,
- No need to ever use the mouse while coding (takes longer to learn, but is faster; this is aided by vim-easymotion and Ctrl-Space),
- It’s been around forever, and frankly, probably always will be.

Complete instructions to Neovim as your IDE - Inspired by [Jarol Rodriguez's vim-python-ide](https://github.com/jarolrod/vim-python-ide).

> **NOTE**: You may want to take a look at [the previous version](https://github.com/ntk148v/neovim-config/tree/legacy).

## 2. Requirements

- [Neovim](https://github.com/neovim/neovim) Version >= 0.5.0
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- Git
- [Powerline-status](https://github.com/powerline/powerline)
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts)

## 3. Installation

- Clone this repository:

```bash
git clone https://github.com/ntk148v/neovim-config ~/.config/nvim
```

- Start `nvim`.

## 4. Plugins

| Name                                                                  | Description                                                                                                                                              |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [fzf.vim](https://github.com/junegunn/fzf.vim)                        | fuzzy finder vim integration                                                                                                                             |
| [coc.nvim](https://github.com/neoclide/coc.nvim)                      | Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers.                                                           |
| [vim-fugitive](https://github.com/tpope/vim-fugitive)                 | A Git wrapper so awesome, it should be illegal                                                                                                           |
| [vim-polygot](https://github.com/sheerun/vim-polyglot)                | A solid language pack for Vim.                                                                                                                           |
| [vim-go](https://github.com/fatih/vim-go)                             | Go development plugin for Vim                                                                                                                            |
| [NERDTree](https://github.com/preservim/nerdtree)                     | A tree explorer plugin for Vim                                                                                                                           |
| [lightline](https://github.com/itchyny/lightline.vim)                 | A light and configurable statusline/tabline plugin for Vim                                                                                               |
| [vim-devicons](https://github.com/ryanoasis/vim-devicons)             | Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more                          |
| [auto-pairs](https://github.com/jiangmiao/auto-pairs)                 | Vim plugin, insert or delete brackets, parens, quotes in pair                                                                                            |
| [incsearch](https://github.com/haya14busa/incsearch.vim)              | Improved incremental searching for Vim                                                                                                                   |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi)         | Multiple cursors plugin for vim/neovim                                                                                                                   |
| [vim-esearch](https://github.com/eugen0329/vim-esearch)               | Perform search in files easily                                                                                                                           |
| [vim-hexokinase](https://github.com/RRethy/vim-hexokinase)            | Neo)Vim plugin for asynchronously displaying the colours in the file (#rrggbb, #rgb, rgb(a)? functions, hsl(a)? functions, web colours, custom patterns) |
| [ack.vim](https://github.com/mileszs/ack.vim)                         | Vim plugin for the Perl module/CLI script 'ack'                                                                                                          |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Nvim Treesitter configurations and abstraction layer                                                                                                     |
| [UltiSnips](https://github.com/SirVer/ultisnips)                      | The ultimate snippet solution for Vim                                                                                                                    |
| [vim-snippets](https://github.com/honza/vim-snippets)                 | vim-snipmate default snippets (Previously snipmate-snippets)                                                                                             |
| [twilight.nvim](https://github.com/folke/twilight.nvim)               | Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter.                                         |
| [vim-signify](https://github.com/mhinz/vim-signify)                   | Show a diff using Vim its sign column                                                                                                                    |

## 5. Screenshot
