#!/usr/bin/env bash

startmaple() {
    [[ -z $1 ]] && WINDOWNAME=MapleLegends || WINDOWNAME=$1
    cd ~/.wine/drive_c/MapleLegendsHD/ || exit 1
    WINEARCH=win32 WINEDEBUG=-all wine explorer /desktop=$WINDOWNAME,1024x768 MapleLegends.exe
}

startgunbound() {
    [[ -z $1 ]] && WINDOWNAME=MapleLegends || WINDOWNAME=$1
    cd /home/rl/.wine/drive_c/GunBound\ Origins || exit 1
    WINEARCH=win32 WINEDEBUG=-all wine explorer /desktop=$WINDOWNAME,1024x768 'Gunbound Origins.exe'
}

stopallmaple() {
    pgrep Maple | xargs kill -9
    pgrep wine | xargs kill -9
    pgrep exe | xargs kill -9
}
