#!/bin/bash

androiddev() {
    local androidstudio_path=/opt/android-studio/bin/
    export PATH=/mnt/research/android-dev/bin/:$PATH:/mnt/research/android-dev/depot_tools/:/mnt/research/android-dev/:$androidstudio_path
    export ANDROID_SDK_ROOT=/mnt/research/android-dev/sdk/
    export ANDROID_HOME=/mnt/research/android-dev/sdk/
}

