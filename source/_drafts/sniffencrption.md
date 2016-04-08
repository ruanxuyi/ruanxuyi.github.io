title: Configure Encrption (WPA2/PSK) on Recon(sniff.py) Project
date: 2015-06-15 18:28:52
updated: 2015-06-15 18:28:52
tags: ParadropLab
categories: Work
---
## Configure Encrption (WPA2/PSK) on Recon(sniff.py)

<img src="http://7xihzu.com1.z0.glb.clouddn.com/sniffs.IMG_1793.jpg" alt="MySummerResearch" style="width:600px;"/>


### Useful info:
**connect to the paradrop server: **  

    ssh pd@paradrop.wings.cs.wisc.edu

IMPORTANT: once the paradrop system(router) hock up into the internet, it automatically VPN to the paradrop server, which parapdrop server can get access to all the haloxxx routers that are onlined.


**List all network interfaces for wireless hardware:**  

    iw dev

Outputs:
    
    phy#1
    Interface moni1
        ifindex 4481
        wdev 0x100001180
        addr 04:f0:21:10:c0:d8
        type monitor
    Interface wlan0
        ifindex 4439
        wdev 0x100001156
        addr 04:f0:21:10:c0:d8
        ssid testRS
        type AP
        channel 36 (5180 MHz), width: 20 MHz (no HT), center1: 5180 MHz

**Configure a network interface:**  

    ifconfig
    
**Scan all the SSIDs within nearby:**  

    iw dev wlan0 scan

<!-- more -->

### Connect to the router:
1. SSID: ParadropXX
2. Password: paradroprocks

### Ssh into the paradrop router:
    ssh root@halo32   

passowrd: 699.tmp  
public ip: 216.26.112.63

### Create `shoot` through front end page.
1. `ifconfig br-lan` 
2. get `inet addr: ` for example: `192.168.60.1`
3. open browswer go to  `192.168.60.1`
4. set up an `app` as `recon`

### Log into the `shoot`
- run command line check:
    <pre><code>python etc/pd/lib/internal/fc/chutestorage.py -ls </code></pre>
- output from terminal:


```
lxc:64c22813-ab61-4c87-9ff6-cac4a03b690f
  state:    running
  struct:   {'net': {'wan': {'type': 'wan', 'intfName': 'eth0', 'ipaddr': '10.100.10.1', 'netmask': '255.255.255.0'}, 'passthroughInterfaces': [], 'wlanPassthrough': 'True', 'radioid': 1}, 'disk': {'size': 123456}, 'cmds': {'firewall': {'post': ['iptables -t nat -I PREROUTING -i tun0 -p tcp -m tcp --dport 6555 -j DNAT --to-destination 10.100.10.1:22', 'iptables -I FORWARD -i tun0 -s 10.6.0.0/24 -d 10.100.10.1 -j ACCEPT', 'iptables -I FORWARD -o tun0 -s 10.100.10.1 -d 10.6.0.0/24 -j ACCEPT']}}}
  runtime:  [{'program': 'echo', 'name': 'sniff args', 'args': 'python /root/recon/sniff.py -i moni1 -t 5 --phy phy1 > /root/sniff_args'}, {'program': 'bash /root/recon/sniff_start.sh', 'name': 'startSniff', 'args': ''}, {'cron': '*/1 * * * *', 'program': 'bash /root/recon/sniff_start.sh', 'name': 'Check sniff is running', 'args': ''}]
  traffic:  []
  resource: {'lan': {'down': 25000, 'up': 25000}, 'cpu': '@resource.cpu.MAX', 'memory': '@resource.memory.MAX'}
  files:  [{'path': '/root', 'sha1': 'None', 'todo': 'EXTRACT', 'name': 'sniff', 'location': '@paradrop.server(sniff/sniff.tar.gz)'}]
  radioid:  1
```
Userful Infomation:  
**UUID** - 64c22813-ab61-4c87-9ff6-cac4a03b690f  
**ipaddr** - 10.100.10.1 <- this is the address for the shoot(app) you just created. ssh into it.

    ssh root@10.100.10.1

User/Pass: root  

### Check if sniff is still running:
    screen -ls
output from terminal:

    There are screens on:
        53.sniff    (Detached)
        28.lxcserver    (Detached)
    2 Sockets in /tmp/screens/S-root.

### Stop stiff:
    bash /root/recon/sniff_disable.sh
    bash /root/recon/sniff_kill.sh 
check if stiff stop:

    screen -ls
    
output from terminal:

    There is a screen on:
        28.lxcserver    (Detached)
    1 Socket in /tmp/screens/S-root. 

### Restart stiff:
    bash /root/recon/sniff_restart.sh

`screen -ls` output from terminal:

    There are screens on:
        782.sniff   (Detached)
        28.lxcserver    (Detached)
    2 Sockets in /tmp/screens/S-root.
    
### Goals:
now I am inside the shoot, I need to use `sniff` to run `hostapd` to create a new access point for the app, so that the SSID created should be encrypted in (WPA2/PSK).   

**BackGround Info:**  
*Recon*:  Recon is the project name for the retail analytics that we are doing. Our initial deployment is in the UW Bookstore on state street.

<http://wirelessathome.wings.cs.wisc.edu/redmine/projects/paradrop/wiki/Recon>


*Sniff*: 


#### Vim up/down/left/right and delete issues:
vim $HOME/.vimrc, add following lines into the file:

```
    set backspace=2 " make backspace work like most other apps
    set nocompatible "must be first line
```

Sample $HOME/.vimrc file:

```
    set nocompatible " must be the first line
    filetype on
    filetype indent on
    filetype plugin on
    syntax on
    set laststatus=2
    set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=   %-40(bytval=0x%B,%n%Y%)\%P
    set ofu=syntaxcomplete#Complete
    set backspace=2 " make backspace work like most other apps
```


**`_modeCreateSSID` inside  `trunk/recon/app/sniff.py`**  

1. insdie the `_modeCreateSSID`, calling lots of functions inside the `iw` library to set up configuration. 
1. res = iw.startHostapd('wlan0', ssid, chan)

    
**`startHostapd` inside `trunk/lib/internal/utils/iw.py`**  
   
1. create a `hostapd.conf` file with infomaiton from the parameters (iface, ssid, channel).    
2. start the hostAPD service that create AP with `hostapd.conf` @`tmp/hostapd.conf` configuration.

** WPA/PSK: **  
For WPA-PSK, 
either **wpa_psk** or wpa_passphrase must be set and **wpa_key_mgmt** must include **WPA-PSK**. Instead of wpa_psk / wpa_passphrase, wpa_psk_radius might suffice.

**add below information: **   
wpa_passphrase=parashootrocks  
wpa_key_mgmt=WPA-PSK  
wpa=2

    def startHostapd(iface, ssid, channel, key, mode, wpa=2):
        .....
        opts.append('wpa=%s' % wpa)
        opts.append('wpa_passphrase=%s' % key)
        opts.append('wpa_key_mgmt=%s' % mode)
        

Question to solve:   
**1. encrption seems not setting up probabaly  **  

    ~ # hostapd -B /tmp/hostapd.conf
    Configuration file: /tmp/hostapd.conf
    Line 5: Invalid PSK 'paradroprocks'.
    1 errors found in configuration file '/tmp/hostapd.conf'
    Failed to set up interface with /tmp/hostapd.conf
    Failed to initialize interface

- did not enable wpa in the first place, inside config file `wpa=3` will fix.  

**2. how to set up wlan0 in side the shoot**  

- correctly start up with `startAP.py` will fix.  

**3. the `self._phy` **  

- it is just the index for physical connection (phy1, phy0, etc)  

TODO:  
1. ~~read through `_modeCreateSSID` on `sniff.py`~~  
2. ~~read through `.config` file, see where encrption comes in~~   
3. ~~useful files to read: `trunk/recon/app/sniff.py`, `hostapd.conf`, and `trunk/lib/internal/utils/iw.py`~~   
4. ~~write `startAP.py` file to test the `hostapd` funcion, if AP comes up without encrption first.~~  
5. ~~update `startAP.py` to make encrption enable~~  
6. ~~fix the error for **hostapd v2.2** ~~
  


**How to configure WPA:  **  
inside `lib/internal/utils/iw.py`:  

```
    def startHostapd(iface, ssid, channel, key, mode, wpa=2):
        ..... # `wpa = 2` indicates WPA2 encrption
        opts.append('wpa_passphrase=%s' % key)
        opts.append('wpa_key_mgmt=%s' % mode)
```


`startAP.py` 

```
    import time
    from lib.internal.utils import iw

    print('Start setting AP connection: ')
    iw.getIwDevList()
    iw.createDev('phy1', 'wlan0', '__ap')
    iw.setDevIP('wlan0', '10.200.200.1')
    iw.bringUp('wlan0')
    iw.killallDnsmasq()
    iw.startDnsmasq('recon', 'wlan0', '10.200.200.1', '10.200.200.10', '10.200.200.100')
    iw.enableNAT('wlan0', 'eth0', '10.200.200.1')
    iw.startHostapd('wlan0', 'testRS', '36', 'paradroprocks', 'WPA-PSK')
    print('Success!')
    while True:
        time.sleep(1)
```

`stopAP.py`:

```
import time
from lib.internal.utils import iw
from lib.paradrop import out

print('Start Deleting AP')
res = iw.disableNAT('wlan0', 'eth0', '10.200.200.1')
if(res):
    print('err@disableNAT')

res = iw.killHostapd()
if(res):
    out.err('!! %s Unable to kill hostapd: %s\n' % (logPrefix(), str(res)))

res = iw.killallDnsmasq()
if(res):
    print('err@killallDnsmasq')

res = iw.startDefaultDnsmasq()
if(res):
    out.err('!! %s Unable to start dnsmasq: %s\n' % (logPrefix(), str(res)))

res = iw.deleteDev('wlan0')
if(res):
    print('err@deleteDev')

print('Success deleting AP')
```


`iw.getIwDevList()` - extract necessary value of info. (`ifindex`, `wdev`, `addr`, `type`) into `ret`, which is a return value. inside the `sniff.py` `iw.getiwDevList` simplely Check if wlan0 already exists. checking method

`iw.createDev('phy1', 'wlan0', '__ap')` - create `wlan0` which has a AP type

`iw.setDevIP('wlan0', '10.200.200.1')` - set up ip, mask for `wlan0`

`iw.bringUp('wlan0')` -  use `ifconfig` to bring up `wlan0`

`iw.killallDnsmasq()` - reset DNS 

`iw.startDnsmasq('recon', 'wlan0', '10.200.200.1', '10.200.200.10', '10.200.200.100')` - set up dns with parameter

`iw.enableNAT('wlan0', 'eth0', '10.200.200.1')` - setup NAT


**Issues for hostapd v2.2:  **  

    Configuration file: /tmp/hostapd.conf
    nl80211: Could not configure driver mode
    nl80211 driver initialization failed.

Just fixed: SSID can not start probably because I did not destroy the `wlan0` probably, now use scripts `stopAP.py`.
it works pefect. (inside `sniff.py` file, method `_modeDestroySSID` does the same thing.)


**Final review on steps to set encrption on sniff**  

1. inside `sniff.py`, modify the line for `iw.startHostapd` to specific key to add:

```
<pre><code>iw.startHostapd('wlan0', 'testRS', '36', 'paradroprocks')</code></pre>
```

2. inside `iw.py`, modeify the indterface for `startHostapd` to enable WPA2 encryption.

```
<pre><code>
def startHostapd(iface, ssid, channel, key, wpa=3, mode='WPA-PSK'):
    ....
    
    # set up WPA2 encryption
    wpa_pw = 'TKIP CCMP'
    rsn_pw = 'CCMP'
    opts.append('wpa=%s' % wpa)
    opts.append('wpa_passphrase=%s' % key)
    opts.append('wpa_key_mgmt=%s' % mode)
    opts.append('wpa_pairwise=%s' % wpa_pw)
    opts.append('rsn_pairwise=%s' % rsn_pw)
</code></pre>
```

3. test files: `startAP.py` and `stopAP.py`

P.S. All of these babes are going to install in Union South next week!!

<img src="http://7xihzu.com1.z0.glb.clouddn.com/sniffs.IMG_1832.JPG" alt="MySummerResearch" style="width:600px;"/>

