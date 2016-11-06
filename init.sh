#!/bin/bash

# $ ls -ltr .build/
# total 0
# -rw-r--r-- 1 root root 0 nov  1 20:22 bootstrap
# -rw-r--r-- 1 root root 0 nov  1 20:22 bootstrap_cache.save
# -rw-r--r-- 1 root root 0 nov  1 20:23 chroot_linux-image
# -rw-r--r-- 1 root root 0 nov  1 20:23 chroot_package-lists.install
# -rw-r--r-- 1 root root 0 nov  1 20:34 chroot_install-packages.install
# -rw-r--r-- 1 root root 0 nov  1 20:34 chroot_package-lists.live
# -rw-r--r-- 1 root root 0 nov  1 20:34 chroot_install-packages.live
# -rw-r--r-- 1 root root 0 nov  1 20:35 chroot_live-packages
# -rw-r--r-- 1 root root 0 nov  1 20:35 chroot_hacks
# -rw-r--r-- 1 root root 0 nov  1 20:35 binary_chroot
# -rw-r--r-- 1 root root 0 nov  1 20:37 binary_rootfs
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_manifest
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_linux-image
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_syslinux
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_disk
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_hooks
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_checksums
# -rw-r--r-- 1 root root 0 nov  1 20:38 binary_iso


if [ "$1" != "" ]; then
    set -x
    case $1 in
        rebuild)
            sudo rm -f .build/binary*
            sudo lb build
            ;;

        cleanbuild)
            sudo lb clean
            sudo lb build
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
          --apt-http-proxy "http://192.168.0.2:3142" \
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
          \ # --binary-images iso \
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
          --iso-preparer 'MAX developers on $(date +"%F_%T")' \
          --iso-publisher "MAdrid_linuX" \
          --iso-volume 'MAX 9.0'


