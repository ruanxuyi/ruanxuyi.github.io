title: Store AP config in dbapi server
date: 2015-06-24 16:37:52
updated: 2015-06-24 16:37:52
tags: ParadropLab
categories: Work

---


## Objective:
At this stage, we send command from dbapi server (`dbapi_tool.py`) to create AP (with `createWiFi` function) on the router side (`sniff.py`). If we store this AP configuration (`hostapd.conf`) into database, so that everytime sniff.py initialiate, it check if AP config file exists in server, if exists, automatically start `hostapd` with the correcponding config retrict from the server to create an AP. Other wise, do not create the AP. 



## Instruction:
1. sniff.py during init needs to look for AP settings from the database and start an AP if they exist

2. dbapi_recon.py the POST_createWifi() command needs to now push the AP settings into the database for configuration. If you are not comfortable writing this code I can do it

3. dbapi_recon.py the POST_destroyWiFi() command needs to remove these settings from the database configuration, again I can write this but not until next week probably.


To start, I would recommend that you change the sniff.py file so that during init it looks for the AP settings and it sets up hostapd if they are found. We can manually change the database configuration to have these extra settings without changing the dbapi_recon.py file, so this would be the easiest thing to do first.


## Thought Process: 

Inside `sniff.py` file,  

`_getConfigSettings(self)` function get the configure files from dbapi server.


`_setConfig(cfg)` read the config file (from dbapi server) and do the reqiured configuration for sniff instance. 

`cfg` - configuration object is a **dictionary** with configure information. 


## Modify files:

`sniff.py`

```
    def _setConfig(self, cfg):
        """
            Takes a config object returned from the dbapi and sets the proper flags.
        """

		...
		
        # set up Wifi access point
        # ?? completed ??
        ap = cfg.get('ap', None)
        if (ap):
            self._modeCreateSSID(ap, completed)
		...
````

 
## Question: 


`_modeCreateSSID(ap, completed)` ?? completed ??






