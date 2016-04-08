title: Configure Encrption (WPA2/PSK) on Recon(sniff.py) Project Part2
date: 2015-06-30 15:35:52
updated: 2015-06-30 15:35:52
tags: ParadropLab
categories: Work
---

## **List of files:**  
### server side:
`dbapi_recon.py` - manage the format of the POST  
`dbapi_tool.py` - take command line from terminal and put parameters into a JSON package  
### router side:
`sniff.py` - receive pacakge from dbapi_server, and extracts the parameters (ssid, chan, pw, etc.)
`iw.py` - the file actual set up necessary configuration for a wireless network, and run commnad through command line and startHostapd to create AP. 

inside `sniff.py`, add folloiwng:

```
    pw = modeData.get('password', None)
    ....
    res = iw.startHostapd('wlan0', ssid, chan, pw)
```

## **Diagram:**   
`dbapi_tool` --- send JSON message to --> `dbapi server` <---receive/send JSON package----> `sniff.py`  

package: JSON object.  

`moni1` - interface to monitor wifi traffic:

    Interface moni1
        ifindex 9361
        wdev 0x100002490
        addr 04:f0:21:10:c0:d8
        type monitor

<!-- more -->

## **Useful commands: **  

    python services/pddb.py -f whois -a halo32

Output indicates which group belong to:

    Calling whois((<services.pdsql.PDSql instance at 0x45b4d40>, 'halo32'))
    -- AP: halo32 (WN855702 :: f2ff1c8d-bec8-4a08-aedc-ab72861fa694) IP: 10.6.0.206 LOC: WiNGS Lab, Madison WI
     OWNER: CS : test (9520f0c5-b884-11e4-a360-00265511043e) GROUP: Test
     RECON: rid: 40, reconid: 10, GROUP: Test


show the difference of the modification: 

    svn diff dbapi/dbapi_recon.py




## **Thought Process:**  

Modify code on `xuyi@paradrop.wings.wisc.edu`  

inside `/home/xuyi/paradrop/trunk/recon/dbapi_tool.py` add password option in


```
def createWifi(dbh, baseUrl, token, group, ssid, chan, pw):
    """
        Creates a wifi network on the group APs provided.
        Arguments:
            @ssid : The SSID to set each device to
            @chan : The channel, can be string like '36+1' for HT40+
            @pw : The password for Wi-Fi
    """
    url = '%s/wifi/%s/create' % (baseUrl, urlEncodeMe(group, ""))
    out.info('-- %s Creating WiFi: %s\n' % (logPrefix(), url))

    msg = {"sessionToken":token}
    msg['ssid'] = ssid
    msg['channel'] = chan	
    msg['pw'] = pw
    
    res = pdweb.post(url, json2str(msg), None, 10)

    if(not pdweb.isOK(res)):
        out.warn('** Failed: %s\n' % str(res))
        exit()
    else:
        out.info('-- %s\n' % pdweb.data(res))

```
Run command with `dbapi_tool` to tell the `sniff.py` in router to setup a AP with password

    python recon/dbapi_tool.py -g Test -f createWifi -a testRXY -a 36 -a paradroprocks
 
send JSON package (ssid, chan, pw) through dbapi server to sniff.py inside halo32.   

Output from  `iw dev wlan0 scan` for `halo32` without password

    BSS 04:f0:21:10:c0:d8(on wlan0)
        TSF: 234855172 usec (0d, 00:03:54)
        freq: 5180
        beacon interval: 100 TUs
        capability: ESS (0x0001)
        signal: -38.00 dBm
        last seen: 1052 ms ago
        Information elements from Probe Response frame:
        SSID: testRXY40
        Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0 
        DS Parameter set: channel 36
        Extended capabilities: 6

**Problems:  **  
1. does not have encryption - inside halo32  
    change code 
    
    ```
        pw = modeData.get('password', None)
    
    ```
    to 
    
    ```
        pw = modeData.get('pw', None)
    
    ```
    
**One more thing that struggle me so long:  **  
since you modify the sniff.py code, you might restart the sniff program to reflect the update on sniff!!  

What I found so far: Password lost either when packed or when received.  

**Message in queue:**  
peek message in queue on the dbapi server: 
    
    curl http://paradrop.wings.cs.wisc.edu:10330/v1/recon/peek/Test

indicate that password was not packed into the JSON package.

    f2ff1c8d-bec8-4a08-aedc-ab72861fa694 :  40 : {"data":{"ssid":"test40","channel":36},"mode":"__WIFI_CREATE"} (1 seconds old)
    

2. SSID name not correct. 

3. if no password indicate, will the AP create sucessfully.

POST and GET
 

Also need to change file in `~/paradrop/trunk/recon/dbapi/dbapi_recon.py`

**question**: will JSON package sent `None` in string or None?  
one `pw = modeData.get('pw', None)` will `pw` get `None` or string(None)

that does not matter, since code in `if(len(pw) < 8):` will catch it and turn it into `None`. 
As to answer the question: yes, the pw will remain the value `None`

## **Current modified files: **  

### server side:
`dbapi_recon.py` @ `~/paradrop/trunk/recon/dbapi/dbapi_recon.py` manage the format of POST.



```
    def POST_wifiCreate(self, request, groupid):
        ...
        # check for format
        token, ssid, chan, pw = pdutils.explode(body, "sessionToken", "ssid", "channel", "pw")
        ...
        # create wifi without password if not in correct format
        if(pw is not None):
            if(len(pw) < 8):
                out.err("!!%s Password at least 8 characters!\n" % logPrefix(ip))
                pw = None
        # Add a message for each ap
        ...
        self.pollResponder.addMessage(ap, sniffconfig.setConfig(sniffconfig.WIFI_CREATE, ssid=s, channel=chan, pw=pw), lambda x: x)
        ...
        
```


`dbapi_tool.py` @ `/home/xuyi/paradrop/trunk/recon/dbapi_tool.py`


```
    def createWifi(dbh, baseUrl, token, group, ssid, chan, pw=None):
        ...
        msg['pw'] = pw
```

### router side:

`iw.py` @ `lib/internal/utils/iw.py`


```
def startHostapd(iface, ssid, channel, key=None):
 ...
 # set up WPA2 encryption
    if(key is not None):
        wpa=3
        mode='WPA-PSK'
        wpa_pw = 'TKIP CCMP'
        rsn_pw = 'CCMP'
        opts.append('wpa=%s' % wpa)
        opts.append('wpa_passphrase=%s' % key)
        opts.append('wpa_key_mgmt=%s' % mode)
        opts.append('wpa_pairwise=%s' % wpa_pw)
        opts.append('rsn_pairwise=%s' % rsn_pw)
```

`sniff.py` @ `root/recon/sniff.py`


```
def _modeCreateSSID(self, modeData, completed):
    ...
    pw = modeData.get('pw', None)
    ...
    res = iw.startHostapd('wlan0', ssid, chan, pw)
    
```

## **Commit the changes:**  

### push updates to server: 
1.Check the status of all files:

    svn status

Outputs:

    xuyi@paradrop:~/paradrop/trunk$ svn status
    ?       envsetup.sh
    M       recon/dbapi_tool.py
    M       dbapi/dbapi_recon.py

2.commit and push: 

    svn ci -m "XR: added password support to SSID startup"
    
Outputs: 

    xuyi@paradrop:~/paradrop/trunk$ svn ci -m "Xuyi: added password support to SSID startup"
    Sending        trunk/dbapi/dbapi_recon.py
    Sending        trunk/recon/dbapi_tool.py
    Transmitting file data ..
    Committed revision 1585.


## **TODO:**  
1. Push the change from router
