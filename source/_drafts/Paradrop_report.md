## TODO: 
- [X] Re-flash image and test chute installation
- [X] Test if autopilot auto re-enable after REBOOT.
- [X] paradrop code functionality on routers. 
- [X] Test stable/reliability of ubuntu snappy on router.
- [X] Potential Dockerfile
- [ ] create and test CP chute on snappy system.
- [ ] */Currently not finsihed/* ensure chute’s functionality on router (virtual router chute, parental-control chute)

## Snappy-core Autopilot: 

Current Issue: Snappy-core has its new process called autopilot that will restart the system once an hour to keep all snaps up-to-date, while as the system provide wifi connection for costumer, we do not want restart of system too often. Currently will disable autopilot for system

```
Broadcast message from root@localhost.localdomain (Mon 2015-11-30 20:00:19 UTC):

snappy autopilot triggered a reboot to boot into an up to date system-- temprorarily disable the reboot by running 'sudo shutdown -c'
The system is going down for reboot at Mon 2015-11-30 20:10:19 UTC!

```

Check if autopilot is on: 

```
(amd64)ubuntu@localhost:~$ snappy config ubuntu-core | grep autopilot
	autopilot: true  
```

Below are three methods to disable autopilot system: 

**Method 1:** 

Temp disable autopilot

```
(amd64)ubuntu@localhost:~$ sudo systemctl stop snappy-autopilot.timer
(amd64)ubuntu@localhost:~$ sudo systemctl disable snappy-autopilot.timer
Removed symlink /etc/systemd/system/multi-user.target.wants/snappy-autopilot.timer.
(amd64)ubuntu@localhost:~$ snappy config ubuntu-core | grep autoupdate
(amd64)ubuntu@localhost:~$ snappy config ubuntu-core | grep autopilot
    autopilot: false
```
Re-enable autopilot: 
```
(amd64)ubuntu@localhost:~$ sudo systemctl enable snappy-autopilot.timer
Created symlink from /etc/systemd/system/multi-user.target.wants/snappy-autopilot.timer to /lib/systemd/system/snappy-autopilot.timer.
(amd64)ubuntu@localhost:~$ sudo systemctl start snappy-autopilot.timer
(amd64)ubuntu@localhost:~$ snappy config ubuntu-core | grep autopilot
    autopilot: true
```

**Method 2:**
```
$ snappy config ubuntu-core > my.yaml
```

Manual change `autopilot -> false`

```
config:
  ubuntu-core:
    autopilot: false
    timezone: Etc/UTC
    hostname: localhost.localdomain
```
Update setting:

```
$ sudo snappy config ubuntu-core my.yaml
```

**Method 3:**

Method provided by official Snappy Ubuntu page: [link](https://developer.ubuntu.com/en/snappy/guides/autopilot/)

## Paradrop functionality Test: 

### `paradrop chute install`


### `paradrop chute stop`

```
adminuser@adminuser-VirtualBox:~/Paradrop$ paradrop chute stop 216.26.106.75 14321 virtual-router
Connecting to node at URI: ws://paradrop.io:9080/ws
Stopping chute...

Chute virtual-router stop success
```


### `paradrop chute start`

```
adminuser@adminuser-VirtualBox:~/Paradrop$ paradrop chute start 216.26.106.75 14321 virtual-router
Connecting to node at URI: ws://paradrop.io:9080/ws
Starting chute...

Chute virtual-router start succes
```
### `paradrop chute delete`

```
adminuser@adminuser-VirtualBox:~/Paradrop/Example-Apps/hello-world$ paradrop chute delete 216.26.106.75 14321 parental-controls
Connecting to node at URI: ws://paradrop.io:9080/ws
Removing chute...

Chute parental-controls delete success

```


### Reboot: 
Both `parental-controls` and `virutal-router` chute individual will automaticall y after boot up ???? 


## Stable/reliability of ubuntu snappy on router.

After disable autopilot, system is relative stable, no signaificant failure or reboot by looking through `syslog`.

## Potential config.yaml & Dockerfile for CP



`config.yaml`

```
owner: Paradrop
date: 2015-07-30
name: captive-portal
description: |
    This app launches a virtual wifi AP with captive portal that provide authentication fucntion.

net:
    wifi: 
        type: wifi
        intfName: wlan0
        ssid: Paradrop-Network
        key: ParadropRocks!
        dhcp:
            lease: 12h
            start: 100
            limit: 50

dockerfile: 
    local: Dockerfile
```

`Dockerfile`

```
# captive-portal
#
# Version 0.0.1

FROM ubuntu:14.04
MAINTAINER Paradrop Team <info@paradrop.io>

RUN apt-get update
RUN apt-get -y install iptables 

# TODO: captive-portal config setting goes here:

RUN echo "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" >> /usr/local/bin/cmd.sh
RUN echo "while true; do sleep 421; done" >> /usr/local/bin/cmd.sh

CMD ["/bin/bash","/usr/local/bin/cmd.sh"]
```



## Current Bugs: 


### 1. No traffic 
chutes (`parental-crontrol`, and `virutal-router`) chutes can be isntalled and run on snappy system, however, currently, there is no internet traffic for both of the chutes.

`virtual-router` chute `PORT` (empty) 
 
```
(amd64)ubuntu@localhost:~$ docker ps
CONTAINER ID        IMAGE                   COMMAND                CREATED             STATUS              PORTS               NAMES
22771c1c6acd        virtual-router:latest   "/bin/bash /usr/loca   3 days ago          Up 11 seconds                           virtual-router

```

`parental-controls` chute `PORT` (empty) 

```
(amd64)ubuntu@localhost:~$ docker ps
CONTAINER ID        IMAGE                      COMMAND                CREATED             STATUS              PORTS               NAMES
d702b44a51d9        parental-controls:latest   "/bin/bash /usr/loca   6 days ago          Up 41 seconds                           parental-controls

```

Some related output from `syslog`: 

```
root@localhost:/var/log# cat syslog | grep "error"
Dec  9 15:15:17 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:15:17Z" level=error msg="Handler for POST /containers/create returned error: No such image: 22771c1c6acd (tag: latest)"
Dec  9 15:15:17 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:15:17Z" level=error msg="HTTP Error: statusCode=404 No such image: 22771c1c6acd (tag: latest)"
Dec  9 15:44:19 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:44:19Z" level=error msg="Handler for POST /containers/create returned error: No such image: 22771c1c6acd (tag: latest)"
Dec  9 15:44:19 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:44:19Z" level=error msg="HTTP Error: statusCode=404 No such image: 22771c1c6acd (tag: latest)"
Dec  9 15:44:20 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:44:20Z" level=error msg="Error from V2 registry: Authentication is required."
Dec  9 15:45:03 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:45:03Z" level=error msg="Handler for POST /containers/{name:.*}/stop returned error: no such id: 643b03a13413"
Dec  9 15:45:03 localhost ubuntu-core-launcher[845]: time="2015-12-09T15:45:03Z" level=error msg="HTTP Error: statusCode=404 no such id: 643b03a13413"

```


Tried: to manual assign port for containter???





### 2. Not able to run `parental-control` and `virtual-router` chutes at same time.

output following error message when tried to run both chute at the same time.

```
adminuser@adminuser-VirtualBox:~/Paradrop$ paradrop chute start 216.26.106.75 14321 virtual-router
Connecting to node at URI: ws://paradrop.io:9080/ws
Starting chute...

ERROR: Failed to start chute.(Error preparing host environment for chute)

```

#### Solution: 
Since both chutes utilize the same `wlan0` interface, change either one of the interface to `wlan1` in both `Dockerfile` and `config.yaml`should works.


### 3. `paradrop list` command not able to disply chute installed

After installed both `parental control` and `virtual-rotuer` chutes, neither of them were listed with `paradrop list` command

```
adminuser@adminuser-VirtualBox:~$ paradrop list
Connecting to node at URI: ws://paradrop.io:9080/ws
routers
	pd.xuyiruan.test
	pd.xuyiruan.xruan
chutes

```

### 4. paradrop start command
If chute does not exist, currently, `start` command does not return `err` msg.  It sping and hang forever. 

```
adminuser@adminuser-VirtualBox:~/Paradrop/Example-Apps/hello-world$ paradrop chute start 216.26.106.75 14321 hello-world
Connecting to node at URI: ws://paradrop.io:9080/ws
Starting chute...

```

### 5. Name_server issue after install paradrop.snap: 

Once `paradrop.snap` installed, issue with name server.
If I delete `paradrop.snap`, NO issue with namer server and interent access.

```
(amd64)ubuntu@localhost:~$ snappy search
Get https://search.apps.ubuntu.com/api/v1/search?fields=alias%2Canon_download_url%2Cdownload_sha512%2Cbinary_filesize%2Cdownload_url%2Cicon_url%2Clast_updated%2Cpackage_name%2Corigin%2Cprices%2Cpublisher%2Cratings_average%2Csupport_url%2Ctitle%2Ccontent%2Cversion&q=: dial tcp: lookup search.apps.ubuntu.com: Temporary failure in name resolution

```

Current workaround: 

modify `/etc/resolv.conf`

```
# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN

nameserver 8.8.8.8
nameserver 192.168.1.1

```



FIX: 
pdconf
dncp.
ps aux | grep dns
192.168.128.1


tried "rpi_cp"


## Resource: 
http://enginechang.logdown.com/posts/248165





## performan: 
- 11.g/n mode.
- njn


Setting up paradrop setting  
- paradrop get config yaml   
- paradrop set config   




## AP speed performance issue: 

// this enables the 802.11n speeds and capabilities ...  You will also need to enable WMM for full HT functionality.

`ieee80211n=1`  
`wmm_enabled=1`



## Chute install issue with two chutes: 

