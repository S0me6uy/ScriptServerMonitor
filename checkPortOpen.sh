#!/bin/bash

# -IP- : IP in fault

touch port-Status.txt

ips=(10.6.0.2)
port=(10000)

for i in "${!ips[@]}"
do
        if [ "$(nc -z -v -u ${ips[$i]} ${port[$i]} 2>&1 | grep succeeded)" ]
        then
                # success part
                if [[ "$(cat port-Status.txt)" == *"-$i-"* ]]
                then
                curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
                --header 'Content-Type: application/json' \
                --data-raw '{"chat_id" : "-<Chat ID>","text" : "Qbittorrent VPN connected !\nTorrents will reboot soon."}'
                echo -n "$(cat port-Status.txt | sed "s/-$i-//g")" > port-Status.txt
                fi
        else
                if [[ "$(cat port-Status.txt)" != *"-$i-"* ]]
                then
                curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
                --header 'Content-Type: application/json' \
                --data-raw '{"chat_id" : "-<Chat ID>","text" : "Qbittorrent not reachable through VPN !\nCheck VPN connection."}'
                echo -n "-$i-" >> port-Status.txt
                fi
        fi
done