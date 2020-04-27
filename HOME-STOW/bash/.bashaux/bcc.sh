#!/usr/bin/env bash

bccprof() {
    [ ! -d $HOME/Projects/bcc/tools ] && exit 0

    export PATH=$PATH:$HOME/Projects/bcc/tools/
}

export bccprof
