title: "Install Chutes on Paradrop Snappy"
date: 2015-08-07 14:17:17
updated: 2015-08-09 22:30:17
tags: paradrop
categories: work
---

[ParadropLabs Github Page](https://github.com/ParadropLabs)

## Deploy Paradrop System into Snappy: ????

### Install snappy tool
 
	$ sudo add-apt-repository ppa:snappy-dev/tools
	$ sudo apt-get update
	$ sudo apt-get upgrade
	$ sudo apt-get install snappy-tools bzr

### Generate paradrop snap file  
	
	snappy build snap

Output from console: 
	
	Generated 'paradrop_0.1.0_all.snap' snap

### Install Paradrop snap file snappy system.

	snappy-remote --url=204.15.28.35 install ./paradrop_0.1.0_all.snap
	
docker 


## Install Example chutes to Paradrop

Checkout out some example apps from Paradrop's Github page. Currently, we have   
1. parental-controls  
2. Virtual Router

### Steps to install `Virtual Router` chute to Paradrop syetem. 

#### check out [ExampleApps](https://github.com/ParadropLabs/Example-Apps) packages from github. 

	
#### Install the pdtools command line tools for Paradrop.

	sudo python2 -m pip install pdtools

#### From the directory with the config.yaml and Dockerfile for the app run (default port: 14321):
	cd Example-Apps/virtual-router/
	paradrop install <host-url> <port> config.yaml

Expect outputs from Terminal:

	216-26-98-167:virtual-router Ruan$ paradrop install 192.168.1.10 14321 config.yaml 
	Installing chute...

	Step 0 : FROM ubuntu:14.04
	 ---> 63e3c10217b8
	Step 1 : MAINTAINER Paradrop Team <info@paradrop.io>
	 ---> Using cache
	 ---> 04525d2c620c
	Step 2 : RUN apt-get update
	 ---> Using cache
	 ---> f1ff01c3903e
	Step 3 : RUN apt-get -y install iptables
	 ---> Using cache
	 ---> ef75fc27792c
	Step 4 : RUN echo "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" >> /usr/local/bin/cmd.sh
	 ---> Running in 6775acbd4174
	 ---> 8fed684bbd86
	Removing intermediate container 6775acbd4174
	Step 5 : RUN echo "while true; do sleep 421; done" >> /usr/local/bin/cmd.sh
	 ---> Running in a02599784a17
	 ---> ea2acf047dfc
	Removing intermediate container a02599784a17
	Step 6 : CMD /bin/bash /usr/local/bin/cmd.sh
	 ---> Running in d075a1183ef1
	 ---> ec7f695de2e2
	Removing intermediate container d075a1183ef1
	Successfully built ec7f695de2e2
	Chute virtual-router create success



Now, you should able to use your Wifi device to connect to one of the WiFi with `SSID: Paradrop-Network` just created. Default Password: ParadropRocks! Feel free to modefiy `SSID` and `Password` through `config.yaml` file. 

**Check current running process:** 

	ps -ef | grep pd

Expected outputs from terminal: 

	(amd64)ubuntu@localhost:~$ ps -ef | grep pd
	root        38     2  0 02:37 ?        00:00:00 [kswapd0]
	root       829     1  7 02:38 ?        00:00:08 python2.7 /apps/paradrop/0.1.0/bin/pd
	root       834     1  7 02:38 ?        00:00:08 python2.7 /apps/paradrop/0.1.0/bin/pd --config
	nobody     974     1  0 02:38 ?        00:00:00 /apps/dnsmasq/2.74/bin/dnsmasq --conf-file=/var/run/pdconfd/dnsmasq-s00000005.conf --pid-file=/var/run/pdconfd/dnsmasq-s00000005.pid
	root       980     1  0 02:38 ?        00:00:00 /apps/hostapd/2.4/bin/hostapd -P /var/run/pdconfd/hostapd-s00000002.pid -B /var/run/pdconfd/hostapd-s00000002.conf
	ubuntu    1072  1040  0 02:40 pts/0    00:00:00 grep --color=auto pd



### Steps to uninstall `Virtual Router` chute to Paradrop syetem???





## Issues: 

1."cannot import optionsForClientTLS" with twisted 13.2.0 Issue.

** Updated Solution (by Mickey): ** Need twisted >= 14.2 inorder to make Twisted to work. Fix by updating `pdtools` package .  

** Old Solution: **

[Twisted issue](http://coderissues.com/questions/31668529/python-imports-wrong-version-of-library-outside-of-virtualenv)


	pip install twisted
	....
	pip freeze

	twistd --version


2.how to find ip addr for the router?????

3.Missing `service_identity` pacakge

	:0: UserWarning: You do not have a working installation of the service_identity
	module: 'No module named service_identity'.  Please install it from <https://pyp
	i.python.org/pypi/service_identity> and make sure all of its dependencies are sa
	tisfied.  Without the service_identity module and a recent enough pyOpenSSL to s
	upport it, Twisted can perform only rudimentary TLS client hostname verification
	
[solution](http://stackoverflow.com/questions/24089484/python-no-module-named-service-identity)

	pip install service_identity



## Useful Infomation: 

### dnsmask
	
	cat /var/lib/misc/dnsmasq.leases 

[apt-get VS. pip](http://askubuntu.com/questions/431780/apt-get-install-vs-pip-install)

[How to set up virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/)

[Site-Packages - pure pyhton vs native/built-in module](http://pythonsimple.noucleus.net/python-install/python-site-packages-what-they-are-and-where-to-put-them)