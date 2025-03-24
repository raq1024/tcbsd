#!/bin/sh

echo "permit nopass Administrator as root" | doas tee -a /usr/local/etc/doas.conf

doas pkg update && doas pkg upgrade
doas pkg install -y mosquitto

#check if the Routes directory already exists
IP=192.168.56.102
DIR="/usr/local/etc/TwinCAT/3.1/Target/Routes"
if [ ! -d "$DIR" ]; then
        mkdir -p "$DIR"
        #register device on MQTT broker lobby
        cp /configs/mqtt-lobby.xml /"$DIR"/
        echo "current config :"
        echo "lobby"
else
        echo "select configuration :
        lobby
        test
        dev"

        read conf

        echo "selected :"
        echo "mqtt-"${conf}".xml"

        doas rm "$DIR"/*
        doas cp configs/mqtt-${conf}.xml "$DIR"/
fi

#restart TwinCAT Router
doas service TcSystemService restart

sleep 5

echo "testing MQTT broker connection..."
mosquitto_pub -d -h ${IP} -p 1883 -t test -m ""