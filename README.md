# Tapps2-AppleM1

TAPPS2 ( https://www.ta.co.at ) is a programming software for the process controlers from TA.
Unfortunatly this software is only running on Windows and Linux.
Apple MacOS is not supported.

This repository provides the framework to run on an Apple-M1.

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

This should also be ready-build available on dockerhub, so maybe only runing the script is all you need after installing Docker.

## Usage: ##

### Command line
Start Tapps2 and make the current directory ($PWD) available under /Work/Files in Tapps2

```
StartTapps2.sh $PWD
```
### GUI (Click)
It is possible to start TAPPS using the app-icon. Quartz & Docker need to be installed, but the docker exec should pull automatically.
It will use your ~/Documents folder -- this might not be what you want if security is on your prio list.
Changing the script is easy though.

## External references ##

https://www.ta.co.at/fileadmin/Downloads/Software/TAPPS2/Linux/64bit



