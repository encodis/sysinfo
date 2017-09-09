#!/bin/bash
# Display background info

# TODO use arrays for this and a function that justifies according to longest name
# TODO use timeout command to stop script hanging on curl etc
# IDEA save latest values in text file to read if timeout ends
# TODO on disk space, check for drive being connected
# change name to desktop-info

#function showDiskSpace() {
#    diskName=$1
#    diskPath=$2
#    diskUsage=`df -hl | awk -v disk="$diskPath" '/disk/' {print $5}`
#    printf "%-15s %3s\n" "$1" "$diskUsage"
#}
# return "n/a" if not available

#showDiskSpace "Mac HD" "disk1"

rootDiskName="Macintosh HD:"
rootDiskUsage=`df -hl | awk '/disk1/ {print $5}'`
#sdDiskName="Storage SD:"
#sdDiskUsage=`df -hl | awk '/Storage SD/ {print $5}'`
media1Name="Media 1:"
media1DiskUsage=`df -h | awk '/Media1/ {print $5}'`
media2Name="Media 2:"
media2DiskUsage=`df -h | awk '/Media 2/ {print $5}'`

printf "%-15s %3s\n" "$rootDiskName" "$rootDiskUsage"
#printf "%-15s %3s\n" "$sdDiskName" "$sdDiskUsage"
printf "%-15s %3s\n" "$media1Name" "$media1DiskUsage"
printf "%-15s %3s\n" "$media2Name" "$media2DiskUsage"

# IDEA size of trash, then red if > some amount, can you get a trash symbol? also for battery

network_location=`networksetup -getcurrentlocation`
#public_ip=`dig +short myip.opendns.com @resolver1.opendns.com`

# note that with ipinfo.io region can be full name e.g. "East Riding of Yorkshire"
# so getting 1st word may not be enough. need function that tries ipinof.io
# then drops down to others after time out, then region etc would be 'n/a'
# TODO timeout command on curl, write last IP to a file in ~ and use if required
# but put * after IP so you know it's out of date

ip_info=`curl -s ipinfo.io`
#ip_info=`curl -s icanhazip.com`
#ip_info=`curl -s ipecho.net/plain`
active_if=`route -n get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2}'`
ssid_name=`networksetup -getairportnetwork $active_if | awk -F"Wi-Fi Network: " '{print $2}' | tr -d '\n'`
local_ip=`ipconfig getifaddr $active_if`
public_ip=`echo $ip_info | tr , '\n' | awk 'NR==1 {print $3}' | tr -d \"`
location=`echo $ip_info | tr , '\n' | awk 'NR==4 {print $2}' | tr -d \"`
country=`echo $ip_info | tr , '\n' | awk 'NR==5 {print $2}' | tr -d \"`

# TODO if some of the location fields are blank then the IP address is too far to centre
# sometimes ipinfo returns blank for some fields, but also geektool is centered so pad for that
# specifically put 'not available', 'not connected', 'No Public IP' or whatever if that's the case
# defo some issues with alignment when IP addresses are long

# en3 is the thunderbolt wired without the dock
# may have to iterate through to get the right location

# TODO find out which enX to use, or at least put as var, or arg to function
echo
if [ "$active_if" = "en8" ]; then
    printf "%-15s %s\n" "$local_ip" "$network_location"
else
    printf "%-15s %s\n" "$local_ip" "$ssid_name"
fi

# TODO left justify IP addr when full length and location is short, so pad location
printf "%-15s %s, %s\n" "$public_ip" "$location" "$country"

# get current active GPU (the one driving the displays)

gpu_curr=`system_profiler SPDisplaysDataType | perl -00 -ne 'print if /Displays:/' | grep -e "Chipset Model" | sed -n -e 's/^.*Model: //p'`

# CPU temp https://github.com/lavoiesl/osx-cpu-temp, could use ASCII colour codes if above a set amount
# supported by geektool now
battery_percent=`pmset -g ps |  sed -n 's/.*[[:blank:]]+*\(.*%\).*/\1/p'`
# in El Capitan
#battery_charging=`pmset -g ps | awk -F" " 'NR==2 {print $3}'`
#battery_remaining=`pmset -g ps | awk -F" " 'NR==2 {print $4}'`
battery_charging=`pmset -g ps | awk -F" " 'NR==2 {print $4}'`
battery_remaining=`pmset -g ps | awk -F" " 'NR==2 {print $5}'`

if [ "$battery_charging" = "discharging;" ]; then
    battery_symbol="-"
    battery_remain=`printf "(%s)" "$battery_remaining"`
elif [ "$battery_charging" = "charging;" ]; then
    battery_symbol="+"
    battery_remain=`printf "[%s]" "$battery_remaining"`
else
    battery_symbol="="
    battery_remain=""
fi

if [ "$battery_remaining" = "(no" ]; then
    battery_remain=""
fi

# IDEA put CPU (mean load, temp etc) and battery stuff on one line, GPU on another (if > 1 present)
echo
printf "%-21s %s%s %s\n" "$gpu_curr" "$battery_symbol" "$battery_percent" "$battery_remain"

# TODO try rounding down on print? rather than -1... or use int()
boottime=`sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//g'`
unixtime=`date +%s`
timeAgo=$(($unixtime - $boottime))
uptime=`awk -v time=$timeAgo 'BEGIN {
        seconds = time % 60;
        minutes = time / 60 % 60;
        hours = time / 3600 % 24;
        days = time / 3600 / 24;
        printf("↑ %.0f days, %.0f hrs, %.0f mins", int(days), int(hours), int(minutes));
        exit }'`
echo $uptime
