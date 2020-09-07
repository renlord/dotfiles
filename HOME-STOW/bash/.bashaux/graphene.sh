#!/usr/bin/env bash

androiddev() {
    export PATH=/mnt/research/android-dev/bin/:$PATH:/mnt/research/android-dev/depot_tools/:/mnt/research/android-dev/:/mnt/research/android-dev/android-studio/bin
}
graphenedev() {
    cd /mnt/research/GrapheneOS || exit 1
    export PATH=/mnt/research/android-dev/bin/:$PATH:/mnt/research/android-dev/depot_tools/:/mnt/research/android-dev/:/opt/android-studio/bin/

    unzip() {
        bsdtar -xf $1
    }
}

graphenegoto() {
    local BASEDIR=/mnt/research/GrapheneOS/grapheneos-10
    [ -d $BASEDIR/$1 ] && cd "$BASEDIR/$1" || echo "$BASEDIR/$1 does not exist"
}
