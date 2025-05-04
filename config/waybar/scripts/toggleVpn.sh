#!/bin/bash

# Replace with your VPN connection name
VPN_NAME="vpn"

# Check if VPN is active
VPN_ACTIVE=$(nmcli connection show --active | grep "$VPN_NAME")

if [ -n "$VPN_ACTIVE" ]; then
    echo "Disconnecting VPN: $VPN_NAME"
    nmcli connection down "$VPN_NAME"
else
    echo "Connecting VPN: $VPN_NAME"
    nmcli connection up "$VPN_NAME"
fi
