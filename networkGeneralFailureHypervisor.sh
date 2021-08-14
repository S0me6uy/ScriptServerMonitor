#!/bin/bash

if [ "$(curl -s -w %{http_code} ifconfig.me --connect-timeout 50 -m 50)" == "000" ]
then
reboot
fi