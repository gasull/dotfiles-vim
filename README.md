dotfiles-vim
============

My ~/.vim and  ~/.vimrc

## Installation

    cd ~/.config
    mkdir vim

Now download dotfiles-vim and copy its vim/ content into ~/.config/vim.

If ~/.vim exists, delete it after backing it up.

    cd ~
    ln -s .config/vim .vim
    sudo aptitude install vim-youcompleteme
    vim-addon-manager install youcompleteme
    cd .config/vim
    mkdir bundle
    cd bundle
    git clone https://github.com/Lokaltog/powerline.git
    git clone https://github.com/Shougo/neomru.vim.git
    git clone https://github.com/Shougo/unite.vim.git
    git clone https://github.com/airblade/vim-gitgutter.git
    git clone https://github.com/altercation/vim-colors-solarized.git
    git clone https://github.com/ap/vim-css-color.git
    git clone https://github.com/docunext/closetag.vim.git
    git clone https://github.com/elzr/vim-json.git
    git clone https://github.com/msanders/snipmate.vim.git
    git clone https://github.com/pangloss/vim-javascript.git
    git clone https://github.com/rking/ag.vim.git
    git clone https://github.com/scrooloose/nerdtree.git
    git clone https://github.com/scrooloose/syntastic.git
    git clone https://github.com/tpope/vim-fugitive.git
    git clone https://github.com/tpope/vim-haml.git
    git clone https://github.com/tpope/vim-pathogen.git
    git clone https://github.com/tpope/vim-sensible.git
    git clone https://github.com/tpope/vim-sleuth.git
    git clone https://github.com/tpope/vim-surround.git
    git clone https://github.com/vim-scripts/TaskList.vim.git
    git clone https://github.com/vim-scripts/taglist.vim.git

Optional (at this moment, only available in Debian Testing, but you can use
[apt-pinning](https://wiki.debian.org/AptPreferences#Pinning)):

    sudo aptitude install silversearcher-ag
