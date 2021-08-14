#!/bin/bash

localhostname = test.com

if [ "$(curl -s -w %{http_code} ifconfig.me --connect-timeout 25 -m 25)" == "000" ] || [ "$(host $localhostname | cut -d " " -f 4)" == "$(curl ifconfig.me)" ]
then
        # fall state
        wg-quick down server
        wg-quick up server
        service qbittorrent restart
        curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
                --header 'Content-Type: application/json' \
                --data-raw '{"chat_id" : "-<Chat ID>","text" : "VPN Interface has restart.\nEverything is fine if you are able to see this message!"}'\
                --connect-timeout 25 -m 25
fi