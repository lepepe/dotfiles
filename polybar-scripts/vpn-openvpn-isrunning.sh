#!/bin/sh

connection=$(pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1)

if [ -n "$connection" ]; then
    echo "VPN up"
else 
    echo "VPN down"
fi
