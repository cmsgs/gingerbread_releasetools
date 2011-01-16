#!/sbin/busybox sh
#
# EFS BACKUP TOOL
# by codeworkx, coolya, finghin (c) 2010, GPLv2
#

rm -rf /mnt/sdcard/backup/efs

mkdir /mnt/sdcard/backup
mkdir /mnt/sdcard/backup/efs

cp -R /efs/ /mnt/sdcard/backup

exit
