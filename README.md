# Using Neovim as an IDE

Neovim is a pretty cool successor to Vim, focusing on compatibility while adding asynchronous plugin functionality and trying to clean up the code base. Having been fed up at various times with both Sublime Text (2 and 3) and Atom, and after realizing how much development I do over SSH, it seemed reasonable to check out using vim (or nvim, in this case) as my IDE. The advantages essentially boil down to:

  - Consistent IDE over SSH or locally,
  - No need to ever use the mouse while coding (takes longer to learn, but is faster; this is aided by vim-easymotion and Ctrl-P),
  - It’s been around forever, and frankly, probably always will be.

Complete instructions to Neovim as your IDE:

1. Create the paths for neovim config and download [Vundle](https://github.com/VundleVim/Vundle.vim) - Vim/Neovim Package Manager:

  ```
  $ mkdir -p ~/.config/nvim/bundle
  $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
  ```

2. Install neovim (For Linux):
  
  ```
  $ sudo add-apt-repository ppa:neovim-ppa/unstable
  $ sudo apt-get update
  $ sudo apt-get install neovim  
  ```

3. Clone init.vim - neovim configuration file to specific path, in this case is `~/.config/nvim/init.vim`:

  ```
  $ git clone https://github.com/ntk148v/neovim_config/init.vim ~/.config/nvim/init.vim
  $ nvim +PluginInstall +q
  ```
4. Enjoy it!
