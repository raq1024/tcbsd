#!/bin/sh

#echo "permit nopass Administrator as root" | doas tee -a /usr/local/etc/doas.conf

#check if the Routes directory already exists
DIR="/usr/local/etc/TwinCAT/3.1/Target/Routes"
if [ ! -d "$DIR" ]; then
        mkdir -p "$DIR"
        #register device on MQTT broker lobby
        cp /configs/mqtt-lobby.xml /"$DIR"/
        echo "current config :"
        echo "lobby"
else
        echo "select configuration :
        prod
        test
        dev"

        read conf

        param=$1

        echo "selected :"
        echo "mqtt-"${conf}".xml"

        rm "$DIR"/*
        cp configs/mqtt-${conf}.xml "$DIR"/
fi

#restart TwinCAT Router
doas service TcSystemService restart