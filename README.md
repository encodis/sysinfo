# Sysinfo

This repo contains two Bash scripts:

-   `sysinfo` generates system information of various types (e.g. battery percentage, or disk usage)
-   `meter` create rectangular and circular meters that can be used to display percentage information.

Both of these are intended to be used by [Geektool](https://www.tynsoe.org/v2/geektool/), so pretty much assume they are running on macOS. `sysinfo` uses the [CoreLocationCLI](https://github.com/fulldecent/corelocationcli) program for finding the machines public IP address, so this must also be installed. In addition, `meter` uses [Graphics Magick](http://www.graphicsmagick.org) to generate images. 

## sysinfo

A Bash shell script that generates a variety of system information. The first argument indicates the type of information -- in some cases additional arguments can follow. The outputs are written to *stdout* with no newline. The options are:

### local

Outputs the local IP address and the current network name, e.g.

```
192.168.1.13  [My Network]
```

### public

Outputs the public IP address (from the https://icanhazip.com or ipinfo.io services) and the best estimate of the geographic location program:

```
92.16.171.170  [United Kingdom]
```

### uptime

This option outputs the system uptime, but reformats it into a more readable form:

```
35 d : 3 h : 0 m
```

### graphics

Prints the current graphics card name:

```
Intel HD Graphics 530
```

### disk

This option outputs the percentage used of a disk, and takes two additional arguments: a string that matches the name of the disk's device, and the name to be displayed. For example:

```
$ sysinfo disk disk1s1 Home
81%

Home
```

In this case the usage and name are separated by a newline. 

### battery

Show battery percentage and additional information depending on the charging status. If the battery is charging then the percentage is preceded by a `+` and followed by the time remaining in brackets:

```
+70%
[1:17]
```

If discharging the symbol turns to a `-` sign and the time left on the battery is in parentheses:

```
-70%
(4:17)
```

If the machine is plugged in and at 100% the symbol is an `=` sign and the number of charging cycles is shown:

```
=100%
147
```

Note that in all cases each value is separated by a newline. 

### cpu

The current CPU percentage, as calculated by summing the percentages in the output of the `ps` command. 

> NOTE: This is likely to be changed to use load averages in the new future.

### memory

The current total memory used, also determined from the `ps` command.

## meter

`meter` uses [Graphics Magick](http://www.graphicsmagick.org) to produce an image showing the increase or decrease of some quantity as either a rectangular (or "bar") meter or a circular meter. By supplying a percentage value the image can be proportionally bigger or smaller; by supplying a configuration map the image can change colour. The effect is a bar that changes length with the percentage value supplied and changes colour at set intervals (e.g. turning red if the value is below 10%, for example).

Its usage is simply:

```
$ meter size colour value file
```

### size

This parameter determines the size and shape of the meter. The general pattern is "XSY", where *X* and *Y* are some dimension (in pixels) and *S* is a shape indicator. *S* can take the following values, which determine what *X* and *Y* mean:

-  If *S* is 'x' then *X* and *Y* and the width and height of the rectangular meter, respectively. If *X* is greater than *Y* the meter will be horizontally oriented, otherwise it will be vertical.

-  If *S* is 'o' then *X* and *Y* are the radius of a circle and the stroke width, respectively. That is, this configuration defines a ring or an annulus.

-  If *S* is 's' then the meter will be square (using *X* as the width and height) but only the colour change is shown -- effectively this is supposed to be like a square LED.

-  If *S* is 'c' the meter will be a circle (using *X* as the radius) but again, only the colour change is shown -- a round LED.

### colour

This is a string that determines how the colour of the meter changes with the value. It is a series of colour/level options, e.g. "green@0:orange@75:red@90". This turns the meter green for values between 0 and 74, orange between 75 and 89 and red for values over 90%. Colour values are those accepted by Graphics Magick. 

If the first element of the configuration string does not contain an "@" sign this colour will be used as a background colour for the meter (the default is "transparent"). For example: "blue:green@0:orange@75:red@90".

### value

This is simply the percentage value to use for the meter display, e.g. "67". Do not include a "%" sign. Values below 0 or above 100 will be set to 0 and 100, respectively.

### file

The file containing the meter image. In the `meter` script change the **SYSINFO_DIR** variable to change where the images are stored (the default is **~/.sysinfo**). 

## Installation

Copy both `sysinfo` and `meter` to a convenient directory on the PATH (e.g. **/usr/local/bin**). Then create scripts in GeekTool as required. 


## Examples

with images


## Caveats

-  This has only been tested on macOS Mojave (10.14.5). The various system utilities in other versions of macOS may produce incorrect results.


## To Do

-  Improve the documentation.
