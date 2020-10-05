#!/usr/bin/env bash

source util/ask.sh

set -x

DOTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Operating in $0"

if [ ! -x "$(command -v stow)" ]; then
    echo "GNU Stow not installed. Install then try again."
fi

stow -v --restow --target="$HOME" --dir="$DOTDIR"/HOME-STOW $(ls $DOTDIR/HOME-STOW)

if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ] && [ ! -f $HOME/.vim/autoload/plug.vim ]; then
    echo "plug.vim not found..."
    if ask "Install plug.vim?" Y; then
        echo "installing plug.vim"
        command -v curl && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        mkdir -p $HOME/.vim/autoload/ && \
            cp $DOTDIR/installs/plug.vim $HOME/.vim/autoload/plug.vim
    else
        echo "NOT installing plug.vim"
    fi
fi

echo "detected pacman pkg manager"
if command -v pacman &>/dev/null && ask "install packages using pkglist.txt on this host?" Y; then
    echo "installing packages..."
    sudo pacman -Syu && \
        sudo pacman -S - < $DOTDIR/pkglist.txt
fi
exit 0
