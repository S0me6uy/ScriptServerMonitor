#!/bin/bash

touch raid-Status.txt

# -X- : Raid number X is in fault

raid_number=(0 1)

for i in "${raid_number[@]}"
do
        if [ "$(mdadm -D /dev/md$i | grep Failed | cut -d " " -f 8)" != "0" ]
        then
                # fail part
                if [[ "$(cat raid-Status.txt)" != *"-$i-"* ]]
                then
                curl --location --request POST 'https://api.telegram.org/<Bot ID>/sendMessage' \
                --header 'Content-Type: application/json' \
                --data-raw '{"chat_id" : "-<Chat ID>","text" : "RAID '"$i"' emergency :\n 1 HDD is fallen !!"}'
                echo -n "-$i-" >> raid-Status.txt
                fi
        else
                if [[ "$(cat raid-Status.txt)" == *"-$i-"* ]]
                then
                curl --location --request POST 'https://api.telegram.org/<Bot ID>/sendMessage' \
                --header 'Content-Type: application/json' \
                --data-raw '{"chat_id" : "-<Chat ID>","text" : "RAID '"$i"' :\n new HDD detected.\n Rebuild in progress..."}'
                echo -n "$(cat raid-Status.txt | sed "s/-$i-//g")" > raid-Status.txt
                fi
        fi
done