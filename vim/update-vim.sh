#!/bin/bash -e
#
# Copyright of this file belongs to the original authors 
#
# Modified from Ian's update-vim.sh
# https://github.com/statico/dotfiles/blob/master/.vim/update.sh
# 
# Updates Vim plugins.
#
# Update everything (long):
#
#   ./update-vim.sh all


vimdir=~/.config/vim
bundledir=$vimdir/bundle
tmp=/tmp/$LOGNAME-vim-update
me=~/.config/vim/update-vim.sh

# URLS --------------------------------------------------------------------

# This is a list of all plugins which are available via Git repos. git:// URLs
# don't work.
repos=(
  https://github.com/Lokaltog/powerline.git
  https://github.com/Shougo/neomru.vim.git
  https://github.com/Shougo/unite.vim.git
  https://github.com/airblade/vim-gitgutter.git
  https://github.com/altercation/vim-colors-solarized.git
  https://github.com/ap/vim-css-color.git
  https://github.com/docunext/closetag.vim.git
  https://github.com/elzr/vim-json.git
  https://github.com/msanders/snipmate.vim.git
  https://github.com/pangloss/vim-javascript.git
  https://github.com/rking/ag.vim.git
  https://github.com/scrooloose/nerdtree.git
  https://github.com/scrooloose/syntastic.git
  https://github.com/tpope/vim-fugitive.git
  https://github.com/tpope/vim-haml.git
  https://github.com/tpope/vim-pathogen.git
  https://github.com/tpope/vim-sensible.git
  https://github.com/tpope/vim-sleuth.git
  https://github.com/tpope/vim-surround.git
  https://github.com/vim-scripts/TaskList.vim.git
  https://github.com/vim-scripts/taglist.vim.git
  )

# Here's a list of everything else to download in the format
# <destination>;<url>[;<filename>]
#other=(
#  'zenburn/colors;http://slinky.imukuppi.org/zenburn/zenburn.vim'
#  'wombat/colors;http://files.werx.dk/wombat.vim'
#  'glsl/syntax;http://www.vim.org/scripts/download_script.php?src_id=3194;glsl.vim'
#  )
other=()

case "$1" in

  # GIT -----------------------------------------------------------------
  repos|repo)
    mkdir -p $bundledir
    for url in ${repos[@]}; do
      if [ -n "$2" ]; then
        if ! (echo "$url" | grep "$2" &>/dev/null) ; then
          continue
        fi
      fi
      dest="$bundledir/$(basename $url | sed -e 's/\.git$//')"
      echo "git-pulling $url"
      cd $dest
      git fetch
      git pull
    done
    ;;

  # TARBALLS AND SINGLE FILES -------------------------------------------
  other)
    set -x
    mkdir -p $bundledir
    rm -rf $tmp
    mkdir $tmp
    pushd $tmp

    for pair in ${other[@]}; do
      parts=($(echo $pair | tr ';' '\n'))
      name=${parts[0]}
      url=${parts[1]}
      filename=${parts[2]}
      dest=$bundledir/$name

      rm -rf $dest

      if echo $url | egrep '.zip$'; then
        # Zip archives from VCS tend to have an annoying outer wrapper
        # directory, so unpacking them into their own directory first makes it
        # easy to remove the wrapper.
        f=download.zip
        $curl -L $url >$f
        unzip $f -d $name
        mkdir -p $dest
        mv $name/*/* $dest
        rm -rf $name $f

      else
        # Assume single files. Create the destination directory and download
        # the file there.
        mkdir -p $dest
        pushd $dest
        if [ -n "$filename" ]; then
          $curl -L $url >$filename
        else
          $curl -OL $url
        fi
        popd

      fi

    done

    popd
    rm -rf $tmp
    ;;

  # HELP ----------------------------------------------------------------

  all)
    $me repos
    $me other
    echo
    echo "Update OK"
    ;;

  *)
    set +x
    echo
    echo "Usage: $0 <section> [<filter>]"
    echo "...where section is one of:"
    grep -E '\w\)$' $me | sed -e 's/)//'
    echo
    echo "<filter> can be used with the 'repos' section."
    exit 1

esac
