#!/bin/bash

touch Nvidia-Smi-Status.txt

if [[ $(nvidia-smi | grep CUDA) ]]
then
        if [ "$(cat Nvidia-Smi-Status.txt)" = "1" ]
        then
        curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
        --header 'Content-Type: application/json' \
        --data-raw '{"chat_id" : "-<Chat ID>","text" : "\\/ --> GPU reconnected to hypervisor : JELLYFIN transcoding capability will be back online in a few time (Wait for container fix) <-- \\/"}'
        echo "0" > Nvidia-Smi-Status.txt
        fi
else
        if [ "$(cat Nvidia-Smi-Status.txt)" = "0" ]
        then
        curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
        --header 'Content-Type: application/json' \
        --data-raw '{"chat_id" : "-<Chat ID>","text" : "/!\\ --> GPU disconnected from hypervisor : JELLYFIN transcoding capability is NOT available anymore until issue have been solved. <-- /!\\"}'
        echo "1" > Nvidia-Smi-Status.txt
        fi
fi