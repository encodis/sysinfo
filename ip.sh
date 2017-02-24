#!/bin/bash
# Network addresses
bold='[1m'
nobold='[22m'

network_location=`networksetup -getcurrentlocation`
public_ip=`dig +short myip.opendns.com @resolver1.opendns.com`
active_if=`route -n get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2}'`
local_ip=`ipconfig getifaddr $active_if`

echo "$public_ip / $local_ip ($network_location)"
