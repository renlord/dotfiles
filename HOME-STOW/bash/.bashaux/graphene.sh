#!/usr/bin/env bash

androiddev() {
    export PATH=/mnt/research/android-dev/bin/:$PATH:/mnt/research/android-dev/depot_tools/:/mnt/research/android-dev/:/mnt/research/android-dev/android-studio/bin
}
graphenedev() {
    cd /mnt/research/GrapheneOS
    export PATH=/mnt/research/android-dev/bin/:$PATH:/mnt/research/android-dev/depot_tools/:/mnt/research/android-dev/
}

graphenegoto() {
    local BASEDIR=/mnt/research/GrapheneOS/grapheneos-10
    [ -d $BASEDIR/$1 ] && cd "$BASEDIR/$1" || echo "$BASEDIR/$1 does not exist"
}
