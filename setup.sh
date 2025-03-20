#!/bin/sh

#echo "permit nopass Administrator as root" | doas tee -a /usr/local/etc/doas.conf

# register device on MQTT broker lobby
doas mkdir /usr/local/etc/TwinCAT/3.1/Target/Routes
doas cp mqtt-lobby.xml /usr/local/etc/TwinCAT/3.1/Target/Routes/