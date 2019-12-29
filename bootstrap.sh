#/usr/bin/env bash

set -x

DOTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Operating in $0"

if [ ! -x "$(command -v stow)" ]; then
    echo "GNU Stow not installed. Install then try again."
fi

stow -v --restow --target="$HOME" --dir="$DOTDIR"/HOME-STOW $(ls $DOTDIR/HOME-STOW)

exit 0
