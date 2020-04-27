#!/usr/bin/env bash

source util/ask.sh

set -x

DOTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Operating in $0"

if [ ! -x "$(command -v stow)" ]; then
    echo "GNU Stow not installed. Install then try again."
fi

stow -v --restow --target="$HOME" --dir="$DOTDIR"/HOME-STOW $(ls $DOTDIR/HOME-STOW)

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] || [ ! -f ~/.nvim/autoload/plug.vim ]; then
    echo "plug.vim not found..."
    if ask "Install plug.vim?" Y; then
        command -v curl && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        echo "installing plug.vim"
    else
        echo "NOT installing plug.vim"
    fi
fi

exit 0
