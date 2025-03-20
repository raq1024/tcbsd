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

        doas rm "$DIR"/*
        doas cp configs/mqtt-${conf}.xml "$DIR"/
fi

#restart TwinCAT Router
doas service TcSystemService restart

mosquitto_pub -d -h 192.168.56.122 -p 1883 -t test -m "" | tee -a result
cat result