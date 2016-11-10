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
            echo "-----------------------------------------------------" >> build.log
            echo " BUILD $(date +"%F_%T")" >> build.log
            sudo lb build | tee -a build.log
            ;;

        cleanbuild)
            sudo lb clean
            echo "-----------------------------------------------------" > build.log
            echo " BUILD $(date +"%F_%T")" >> build.log
            sudo lb build | tee -a build.log
            ;;

        purge)
            sudo lb clean --purge
            rm -f build.log
            ;;

        build)
            echo "-----------------------------------------------------" >> build.log
            echo " BUILD $(date +"%F_%T")" >> build.log
            sudo lb build | tee -a build.log
            ;;
    esac
    exit
fi


MIRROR="http://archive.ubuntu.com/ubuntu"
MIRROR_BT="http://192.168.0.2:3142/archive.ubuntu.com/ubuntu"

lb config --mode ubuntu \
          --distribution xenial \
          --architectures amd64 \
          --archive-areas "main universe multiverse restricted" \
          --parent-archive-areas "main universe multiverse restricted" \
          --apt-recommends true \
          --apt-http-proxy "http://192.168.0.2:3142" \
          \
          --mirror-bootstrap $MIRROR_BT \
          --parent-mirror-bootstrap $MIRROR_BT \
          \
          --mirror-chroot $MIRROR \
          --mirror-chroot-security $MIRROR \
          --mirror-chroot-volatile $MIRROR \
          --mirror-chroot-backports $MIRROR \
          \
          --parent-mirror-chroot $MIRROR \
          --parent-mirror-chroot-security $MIRROR \
          --parent-mirror-chroot-volatile $MIRROR \
          --parent-mirror-chroot-backports $MIRROR \
          \
          --mirror-binary $MIRROR \
          --mirror-binary-security $MIRROR \
          --mirror-binary-volatile $MIRROR \
          --mirror-binary-backports $MIRROR \
          \
          --parent-mirror-binary $MIRROR \
          --parent-mirror-binary-security $MIRROR \
          --parent-mirror-binary-volatile $MIRROR \
          --parent-mirror-binary-backports $MIRROR \
          \
          --source false \
          --apt-source-archives false \
          --debian-installer false \
          \
          --linux-flavours generic \
          --linux-packages "linux-image linux-headers" \
          --keyring-packages "ubuntu-keyring" \
          \
          --binary-images iso-hybrid \
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

# --binary-images iso \

# --binary-images iso \
