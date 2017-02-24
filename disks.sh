# Current Disk Usage %
bold='[1m'
nobold='[22m'
rootDiskName="Macintosh HD"
rootDiskUsage=`df -hl | awk '/disk1/ {print $5}'`
sdDiskName="Storage SD"
sdDiskUsage=`df -hl | awk '/Storage SD/ {print $5}'`
media1Name="Media1"
media1DiskUsage=`df -h | awk '/Media1/ {print $5}'`
media2Name="Media 2"
media2DiskUsage=`df -h | awk '/Media 2/ {print $5}'`

echo "${bold}${rootDiskName}:${nobold} ${rootDiskUsage}"
echo "${bold}${sdDiskName}:${nobold}   ${sdDiskUsage}"
echo "${bold}${media1Name}:${nobold}       ${media1DiskUsage}"
echo "${bold}${media2Name}:${nobold}      ${media2DiskUsage}"
