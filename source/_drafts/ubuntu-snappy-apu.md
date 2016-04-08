title: "Ubuntu Snappy"
date: 2015-07-13 13:20:18
updated: 2015-07-13 13:20:18
tags: 
- ParadropLab
- UbuntuSnappy
categories: Work
---


# Description: 
Paradrop 2.0 will be deployed on the newest Ubuntu 15.04. The following task will try to deploy Ubuntu snappy on the paradrop router.



# Todo: 

1. ~~flash img into SD card~~
2. ~~Boot system with SD card and see if everything goes well~~
3. ~~figure out how to ssh into the system - either through ethernet or serial~~
4. ~~fix driver issue for wan port(it works)~~
4. ~~fix the driver issues for wirless card(it works)~~



# Writing the .img file to the SD card

Run the following command from terminal to verify the path of SD card: 

	diskutil list

The output shows all the disks current mounted on the system. Look for the path of your SD card by `size` and `NAME`

	/dev/disk3
	#:                       TYPE NAME                    SIZE       IDENTIFIER
	0:     FDisk_partition_scheme                        *8.0 GB     disk3
	1:                 DOS_FAT_32 RPISDCARD               8.0 GB     disk3s1	
In this case `dev/disk3` is the path for my SD card. 


Unmount the current partition on the SD card in order to sucessfully use `dd` to write.

	diskutil unmount /dev/disk3s1

Use `dd` command to write image file (Note the `r` added to rdisk3 which drastically improves write performance) to the disk. `if` (input file), `of` (output file), `bs` (block size in byte). Determine the best `bs` for your SD card, use [link](http://jingyan.baidu.com/article/d45ad148e203f969552b800a.html) for detail.

	sudo dd if=ubuntu-15.04-snappy-amd64-generic.img of=/dev/rdisk3 bs=1m
	
Different SD card take different time to finish the process. use `CTRL+T` to see the current status of `dd`.


# Testing through Terminal

If you would like to ssh into the system through **serial**, please use 9600 baud rate. (baud rate 115200 will not work)

Connect the serial output through USB and start Putty section with buad of 9600. Plug in SD card into the router and plug in power. The Ubunta should automatically boot and run. 

# Log into the snappy ubuntu core

login: ubuntu  
password: ubuntu  

<img src="http://7xihzu.com1.z0.glb.clouddn.com/work.ubuntu15.jpg" alt="Snappy Ubuntu Core" style="width:600px;"/>

<!-- more -->

# Current issues: 


http://pcengines.info/forums/?page=post&id=E25612E9-84F0-4DCF-A876-1E92FD1D065C

https://forum.pfsense.org/index.php?topic=74301.0



**SSH with serial:  **   
	9600 VS 115200?  
	~~read dales's comments - it is about how to ssh into through serial, which i have doon~~  
	~~read dales's post on that. 115200? ~~  
	~~ubuntu startup scripts?  - not need to worry about it now since i am able to ssh into through serial.~~  
	
**SHH with network router:  **  
	fix the wireless driver. - wireless driver was acutually working. 	   
	
# Test wireless function

To bring wirelss wlan0 up, try following commands: 

	sudo ifconfig wlan0 up

Test wireless function with `scan`

	sudo iw dev wlan0 scan

# Hello Snappy Ubuntu

## snappy info	
	
	(amd64)ubuntu@localhost:~$ snappy info
	release: ubuntu-core/15.04/stable
	architecture: amd64
	frameworks: webdm
	apps: 

## check version of current installed components

flag (*) indicates the version of components currently running on. 

	ubuntu@localhost:~$ snappy list -v
	Name          Date       Version Developer 
	ubuntu-core   2015-06-11 3       ubuntu*   
	webdm         2015-06-11 0.9     *         
	generic-amd64 2015-06-11 1.1.1             
	generic-amd64 2015-07-14 1.4     *         


## check update for system

	snappy list -uv

## search for package

	sudo snappy search docker

## install packeage

	snappy install docker

# Reference

[Write image into SD card](http://raspberrypi.stackexchange.com/questions/4144/writing-img-file-to-sd-card-from-a-mac)

[DD command detail](http://jingyan.baidu.com/article/d45ad148e203f969552b800a.html)

[WLE200NX](http://store.netgate.com/WLE200NX-80211nabg-miniPCIe-Card-P1763.aspx)

[madwifi](https://help.ubuntu.com/community/WifiDocs/Driver/Atheros?highlight=%28%28WifiDocs%7CDriver%7CAtheros%29%29)

[Snappy Inernal](https://developer.ubuntu.com/en/snappy/guides/	)
