#!/bin/busybox sh

if [[ ! -z $CHECK_CONN_FREQ ]] 
    then
        freq=$CHECK_CONN_FREQ
    else
        freq=120
fi

if [[ ! -z $SILENT ]] 
    then
        verbose=0
    else
        verbose=1
fi

echo "WiFi Connect starting...\n"

sleep 5

while [[ true ]]; do
    if [ $verbose -eq 1 ]; then echo "Checking !!!!!! internet connectivity ..."; fi
    wget --spider --no-check-certificate 1.1.1.1 > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        if [ $verbose -eq 1 ]; then echo "Your device is already connected to the internet.\nSkipping setting up Wifi-Connect Access Point. Will check again in $freq seconds."; fi        
    else
        if [ $verbose -eq 1 ]; then echo "Your device is not connected to the internet.\nStarting up Wifi-Connect.\n Connect to the Access Point and configure the SSID and Passphrase for the network to connect to."; fi        
        DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket /usr/src/app/wifi-connect -u /usr/src/app/ui -o 3000
    fi

    sleep $freq

done


/bin/busybox sh /usr/bin/balena-idle
