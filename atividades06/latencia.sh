#!/bin/bash

while read ip
do
    TEMPO=$(ping -c 4 "$ip" 2>/dev/null | grep 'rtt' | cut -d '=' -f 2 | cut -d '/' -f 2)
    
    if [ -n "$TEMPO" ]; then
        echo "$TEMPO $ip"
    fi

done < "$1" | \
sort -n | \
while read TEMPO IP
do
    echo "$IP ${TEMPO}ms"
done
