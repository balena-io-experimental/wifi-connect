#!/bin/busybox sh

if [[ ! -z $SSID ]] 
    then
        ssid="-s $SSID"
    else
        ssid=''
fi

if [[ ! -z $PASS ]] 
    then
        ssid="-p $PASS"
    else
        pass=''
fi


sleep 5

while [[ true ]]; do
    wget --spider --no-check-certificate 1.1.1.1 2>&1

    if [ $? -eq 0 ]; then
        printf 'Skipping WiFi Connect\n'
    else
        printf 'Starting WiFi Connect\n'
        DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket /usr/src/app/wifi-connect -u /usr/src/app/ui $ssid $pass
    fi

    sleep 120

done


/bin/busybox sh /usr/bin/balena-idle