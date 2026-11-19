#!/bin/sh

#Ensure onewifi is up and running
while [ ! -e /tmp/wifi_initialized ] || [ ! -e /tmp/wifi_dml_complete ] ;
do
   sleep 1;
done

#Ensure backhaul connectivity is established on the backhaul STA interface.
#The AL MAC in EasymeshCfg.json is written by the agent after it starts, so it cannot be used here.
bsta_ifname="wifi1.3"
channel_exists=`iw dev $bsta_ifname info 2>/dev/null | grep channel | wc -l`
ssid_exists=`iw dev $bsta_ifname info 2>/dev/null | grep ssid | wc -l`

while [ "$channel_exists" != 1 ] && [ "$ssid_exists" != 1 ] ;
do
  sleep 1;
  channel_exists=`iw dev $bsta_ifname info 2>/dev/null | grep channel | wc -l`
  ssid_exists=`iw dev $bsta_ifname info 2>/dev/null | grep ssid | wc -l`
done

#Run udhcpc to get ipaddr of brlan0 interface for connected clients internet connectivity
brlan0_ip_addr=`ifconfig brlan0 | grep "inet addr:" | cut -d ':' -f2 | cut -d ' ' -f1 | wc -l`
if [ "$brlan0_ip_addr" = 0 ]; then
udhcpc -i  brlan0 -q
fi
