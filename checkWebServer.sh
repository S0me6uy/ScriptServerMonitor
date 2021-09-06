#!/bin/bash

touch checkWebServers.txt

nameServer=(google.com amazon.fr)
publicNames=(GOOGLE AMAZON)

for i in "${!nameServer[@]}"
do
	response=$(curl -sL -w %{http_code} -I https://${nameServer[$i]} -o /dev/null --connect-timeout 25 -m 25)
	if [ "$response" != "200" ] && [ "$response" != "403" ] && [ "$response" != "503" ]
	then
		response2=$(curl -sL -w %{http_code} -I https://${nameServer[$i]} -o /dev/null --connect-timeout 25 -m 25)
		if [ "$response2" != "200" ] && [ "$response2" != "403" ] && [ "$response2" != "503" ]
        	then
			# fail part
			if [[ "$(cat checkWebServers.txt)" != *"-$i-"* ]]
	        then
  				curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
		        --header 'Content-Type: application/json' \
		        --data-raw '{"chat_id" : "-<Chat ID>","text" : "/!\\Server Emergency :/!\\\nWeb Service '"${publicNames[$i]}"' is down!\nFurther investigation need to be done"}'
		        echo -n "-$i-" >> checkWebServers.txt
    		fi
		fi
	else
		if [[ "$(cat checkWebServers.txt)" == *"-$i-"* ]]
    	then
    		curl --location --request POST 'https://api.telegram.org/bot<Bot ID>/sendMessage' \
	        --header 'Content-Type: application/json' \
	        --data-raw '{"chat_id" : "-<Chat ID>","text" : "Web Service '"${publicNames[$i]}"' is back online!"}'
	        echo -n "$(cat checkWebServers.txt | sed "s/-$i-//g")" > checkWebServers.txt
    	fi
	fi
done


