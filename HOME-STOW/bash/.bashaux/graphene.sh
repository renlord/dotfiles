#!/usr/bin/env bash

graphenedev() {
    cd /mnt/research/GrapheneOS || exit 1
    export PATH=/mnt/research/android-dev/bin/:$PATH:/mnt/research/android-dev/depot_tools/:/mnt/research/android-dev/:/opt/android-studio/bin/

    unzip() {
        bsdtar -xf $1
    }
}

graphenects() {
    unset ANDROID_HOME
    export ANDROID_HOME=/mnt/research/android-dev/sdk/
    export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/30.0.2:$ANDROID_HOME/ndk-bundle"
}

graphene11goto() {
    local BASEDIR=/mnt/research/GrapheneOS/grapheneos-11
    [ -d $BASEDIR/$1 ] && cd "$BASEDIR/$1" || echo "$BASEDIR/$1 does not exist"
}
