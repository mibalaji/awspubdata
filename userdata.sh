#!/bin/bash

DEVICE=/dev/$(lsblk -n | awk '$NF != "/" {print $1}' | tail -1)
FS_TYPE=$(file -s $DEVICE | awk '{print $2}')
MOUNT_POINT=/data

mkdir $MOUNT_POINT
mount $DEVICE $MOUNT_POINT

mkdir -p ~/.aws/

echo /usr/bin/aws s3 sync /data/ s3://${aws_s3_bucket.bucket.bucket} > /tmp/sync.s3

wget http://regexp.s3.amazonaws.com/list.html

/usr/bin/aws s3 cp list.html s3://${aws_s3_bucket.bucket.bucket}

at now +2 minutes <<< "/usr/bin/aws s3 /data sync s3://${aws_s3_bucket.bucket.bucket} "

