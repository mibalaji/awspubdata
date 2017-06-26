#!/bin/bash

DEVICE=/dev/$(lsblk -n | awk '$NF != "/" {print $1}' | tail -1)
FS_TYPE=$(file -s $DEVICE | awk '{print $2}')
MOUNT_POINT=/data

mkdir $MOUNT_POINT
mount $DEVICE $MOUNT_POINT

mkdir -p ~/.aws/

