# ScriptServerMonitor

Those different scripts could help you to manage your own server and notify you when issues happen (Telegram only in my case).


## Installation and use

You can download an run each script individually : there is no link between them

I use them periodically thanks to crontab, and in the following example every minutes.

```bash
  * * * * * /root/networkCheck.sh
```


    
## Features

- ``checkGPUPassthrough.sh`` : Check if GPU is well available in both hypervisor and container using nvidia drivers.
- ``checkPortOpen.sh`` : Check if a port at an IP is open and available through the network.
- ``checkQBInterface.sh`` : In Qbittorrent container, check is VPN link is not down or broke, and relaunch new connection.
- ``checkRaidStatus.sh`` : Check RAID disk drive status
- ``checkWebServer.sh`` : Check multiple web services availability.
- ``networkGeneralFailureHypervisor.sh`` : Check if hypervisor is every time connected to internet, and after 50 secs without, reboot hypervisor.
- ``start.sh`` : script to rebuild RAID groups and mount every partitions.
  
