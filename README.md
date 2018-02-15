# Using NeoVim as an Python IDE

[Neovim](https://neovim.io/) is a pretty cool successor to Vim, focusing on compatibility while adding asynchronous plugin functionality and trying to clean up the code base. Having been fed up at various times with both Sublime Text (2 and 3) and Atom, and after realizing how much development I do over SSH, it seemed reasonable to check out using vim (or nvim, in this case) as my IDE. The advantages essentially boil down to:

  - Consistent IDE over SSH or locally,
  - No need to ever use the mouse while coding (takes longer to learn, but is faster; this is aided by vim-easymotion and Ctrl-Space),
  - It’s been around forever, and frankly, probably always will be.

Complete instructions to Neovim as your IDE - Inspired by [Jarol Rodriguez's vim-python-ide](https://github.com/jarolrod/vim-python-ide):

1. Create the paths for neovim config and download [Vim-plug](https://github.com/junegunn/vim-plug) - Vim/Neovim Package Manager:

  ```
  $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

2. Install neovim (For Linux). With other enviroments, please check [installation documentation](https://github.com/neovim/neovim/wiki/Installing-Neovim):
  
  ```
  $ sudo add-apt-repository ppa:neovim-ppa/unstable
  $ sudo apt-get update
  $ sudo apt-get install neovim -y
  # The following lines is needed for python-mode
  $ pip2 install --user -U neovim
  $ pip3 install --user -U neovim
  # Install the silversearcher
  $ sudo apt-get install silversearcher-ag -y
  ```

3. Install [powerline-status](https://powerline.readthedocs.io/en/latest/installation.html):

  ```
  $ sudo -H pip3 install powerline-status
  ```

4. Clone init.vim - neovim configuration file to specific path, in this case is `~/.config/nvim/init.vim`:

  ```
  $ cd ~/.config/nvim/
  $ wget https://raw.githubusercontent.com/ntk148v/neovim_config/master/init.vim
  $ nvim +PlugInstall +q
  ```

5. Enjoy it!


> NOTE: You can use it by clone this repo and run install.sh script as well.
