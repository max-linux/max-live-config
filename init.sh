#!/bin/bash

if [ "$1" != "" ]; then
    set -x
    case $1 in
        rebuild)
            rm -f .build/binary*
            ;;

        purge)
            sudo lb clean --purge
            ;;

        build)
            sudo lb build
            ;;
    esac
    exit
fi


MIRROR="http://archive.ubuntu.com/ubuntu"

lb config --mode ubuntu \
          --distribution xenial \
          --architectures amd64 \
          --archive-areas "main universe multiverse" \
          --parent-archive-areas "main universe multiverse" \
          --apt-recommends false \
          --apt-http-proxy "http://localhost:3142" \
          \
          --parent-mirror-bootstrap $MIRROR \
          --parent-mirror-chroot-security $MIRROR \
          --parent-mirror-binary $MIRROR \
          --parent-mirror-binary-security $MIRROR \
          --mirror-bootstrap $MIRROR \
          --mirror-chroot-security $MIRROR \
          --mirror-binary $MIRROR \
          --mirror-binary-security $MIRROR \
          --source false \
          --apt-source-archives false \
          --debian-installer false \
          \
          --linux-flavours generic \
          --linux-packages "linux-image linux-headers" \
          --keyring-packages "ubuntu-keyring" \
          \
          --binary-images iso-hybrid \
          \ #--binary-images iso \
          --syslinux-theme "max90" \
          --win32-loader false \
          \
          --firmware-binary false \
          --firmware-chroot false \
          --zsync false \
          \
          --initramfs casper \
          --initsystem none \
          \
          --iso-application "MAX 9.0" \
          --iso-preparer 'MAX developers on $(date)' \
          --iso-publisher "MAdrid_linuX" \
          --iso-volume 'MAX 9.0'


