#!/usr/bin/env bash

scan1sideA4doc() {
    scanf simplex
}

scan2sideA4doc() {
    scanf duplex
}

scanreceipt(){
    scanf simplex Gray 500 100 receipt
}

exit_cmd() {
    printf "scanf [simplex/duplex] [Gray/Lineart/Color]"
    exit 1
}

scanf() {
    local mode=$1
    local color=$2
    local height=$3
    local res=$4
    local scantype=$5
    SCAN_DIR="SCAN-$(date +%Y%m%d_%H%M%S)"
    DATE="$(date +%Y%m%d_%H%M%S)"
    mkdir "${SCAN_DIR}"
    cd "${SCAN_DIR}" || exit 1
    echo "Scanning to DIR: $(pwd)"
    [ -z $mode ] && exit_cmd
    [ -z $height ] && height=297
    [ -z $color ] && color="Gray"
    [ -z $res ] && res=300
    [ -z $scantype ] && scantype="doc"
    case $mode in
        simplex)
            scanimage -d fujitsu --format pnm --page-height $height --mode $color --resolution $res --batch="%d.pnm" --ald=yes
            ;;
        duplex)
            scanimage -d fujitsu --format pnm --page-height $height --mode $color  --resolution $res --batch="%d.pnm" --ald=yes --source "ADF Duplex"
            ;;
    esac
    echo "scan completed"
    COUNT="$(ls ./*.pnm | wc -l)"
    local _i=1
    echo "converting $COUNT pnm files to pdf"
    while [ "$COUNT" -ne 0 ]; do
        _fs=$(ls -v ./*.pnm | head -n 10)
        convert -density $res $_fs $_i.pdf
        rm $(ls -v ./*.pnm | head -n 10)
        _i=$((_i+1))
        COUNT="$(ls ./*.pnm | wc -l)"
    done
    echo "merging pdf to single file"
    [ -z "$NAME" ] && NAME="SCAN"
    _scanoutput="$NAME-$DATE-$scantype.pdf"
    pdftk $(ls -v ./*.pdf) output "$_scanoutput"
    mv "$_scanoutput" ../
    cd ..
    rm -rf "${SCAN_DIR}"
    echo "SCAN COMPLETE"
}
