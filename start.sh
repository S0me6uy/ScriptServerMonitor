#!/bin/bash

mdadm -A /dev/md0 /dev/sda1 /dev/sdd1
mdadm -A /dev/md1 /dev/sdb1 /dev/sdc1
mount /dev/md1 /storage/4TO1/
mount /dev/md0p1 /storage/database/
mount /dev/md0p3 /storage/backup/
mount /dev/md0p4 /storage/FTP/
mount /dev/md0p6 /storage/photos/
mount /dev/md0p7 /storage/samba/
mount /dev/sde1 /storage/Deluge/
mount /dev/md0p2 /storage/ZoneMinder/

curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
        --header 'Content-Type: application/json' \
        --data-raw '{"chat_id" : "-<Chat ID>","text" : "Server fully restarted!"}'