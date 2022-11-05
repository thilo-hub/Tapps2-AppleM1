# Tapps2-AppleM1

## The Problem ##

Execute Tapps2 software on MacOS-M1.
This software is currently not available for MacOS.

This HW can be prorgrammed using a GUI tooling (Tapps2) on WIndows and recently also on Linux (X11)

Only having an Apple-M1 (ARM-64) based system, the solution is:
Using docker and qemu to execute the software and MacOS XQuartz to provide the X11 interface.

##
Building/creating the Dockerfile:

```
docker build --platform linux/amd64 -t thiloj/tapps2 .
```

This should also be abailable on dockerhub, so maybe only runing the script is all you need after installing Docker.

## Usage: ##
Start Tapps2 and make the current directory available under /Work/Files in Tapps2

```
StartTapps2.sh $PWD
```

## External references ##

https://www.ta.co.at/fileadmin/Downloads/Software/TAPPS2/Linux/64bit



