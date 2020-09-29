#!/bin/bash

boundtablet2primarydisplay() {
    if ! command -v xsetwacom &> /dev/null
    then
        echo "xsetwacom not found, bailing"
        exit 1
    fi
    local stylusId=$(xsetwacom --list | awk '/STYLUS/ {print $9}')
    local eraserId=$(xsetwacom --list | awk '/ERASER/ {print $9}')
    xsetwacom --set $stylusId MapToOutput $(xrandr | awk '/primary/ {print $4}')
    xsetwacom --set $eraserId MapToOutput $(xrandr | awk '/primary/ {print $4}')
}

export boundtablet2primarydisplay
