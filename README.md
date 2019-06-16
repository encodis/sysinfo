try also making a simple bar for each disk

See https://ownyourbits.com/2017/07/16/a-progress-bar-for-the-shell/ for a progress bar that uses half block chars (https://en.wikipedia.org/wiki/Block_Elements#Character_table) but you'd have to use 0.25 increments rather than 1/8th I think

also http://www.macosxtips.co.uk/geeklets/system/disk-used-graphic/ which just changes the width of the glet itself, but needs a background image

- could we do same but with echo block for length?
- could you use Applescript to move image glet to wherever the main one was? and possibly even tell it to resize itself to same dimensions as the main one? then just need a simple image of any colour and size for bg
- so you'd have SSD-Disk-use and SSD-Disk-use-bg glets
- could you also tell it to set bg colour of size glet (i.e. itself) if > 90% etc ?

put stuff like bg images in /usr/local/lib ?

could also re-do IP stuff using font awesome to get wifi/net symbols, globe for public IP etc

also https://www.creativebloq.com/typography/symbol-fonts-2131972

https://pages.uoregon.edu/leblanc/Geektools/Backgrounds%20behind%20geeklets.pdf

use graphicsmagic to make a meter + a label, then produce a unique image name. would need to run the meter + the calc scripts. then if disk not mounted just have blank image
e.g.

makemeterimg sizeXsize value warning label imagename.png  


corelocationcli -format "%address" | tail -1

to get current country

then have row of disk meters, and separate battery, GPU and uptime

batter could be horizontal bar, done with GM, % embedded in middle and arrows left/right for charge/drain. the arrow would be on left of boundary

```
######## 70% #####_____ ->

######### 100% ####### <-
```

but the charge/discharge could be separate script as now, but meter just graphical? or '+5h:15m' for charging time, '-5h:16m' for time left. or even use '>5h' or '<5h' indicating which way the meter is going. can also have +/- in the % on the bar itself

hmeter width height bgcolor normal_color warning% warn_col crit% crit_col label_format percent output.png

- label in center if empty dont print
- label format e.g. "+P%" where P is placeholder for value? or just have label and calculate outside script

cmeter size width bgcolor normal_color warning% warn_col crit% crit_col label_format percent output.png

- same for label
- size is square
- width is width of circle
- bgcolor is bg of circle not whole image

have makecirclemeter with % in the middle, label underneath. then a number of disk info scripts that update disk1.png disk2.png etc

also if disk not mounted then keep the % in the save file, but colour so you know it's out of date.

ALSO have a CPU load meter, but looks at longer term e.g. load over last 5 mins
and on display CPU/mem could be a circle/square that turns read/green etc. use same circle meter but a circle not a ring. and for the square set sizes accordingly?


https://apple.stackexchange.com/questions/39345/can-i-view-system-stats-in-the-terminal

