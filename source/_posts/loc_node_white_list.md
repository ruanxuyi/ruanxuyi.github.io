title: loc_node white list implementation
date: 2015-07-02 14:35:52
updated: 2015-07-02 14:35:52
tags: ParadropLab
categories: Work

---
<img src="http://7xihzu.com1.z0.glb.clouddn.com/work.loc_white_list.jpg" alt="Localization Project" style="width:600px;"/>


## TODO: 
1. end-to-end dbapi testing


## Objective: 

Create a white list filter for specfic MAC address to allow localization data to pass to `loc` instance from `loc_node`.
look at code in `loc_node` to see poetential place to add white list filtering in.

## Files to read/modify: 
1. `/home/xuyi/paradrop/trunk/scripts/recon_locmgmt.py `
2. `/home/xuyi/paradrop/trunk/scripts/recon_loc.conf ` - configuration file to create specific `loc` instances follow by `loc_node`
3. `/home/xuyi/paradrop/trunk/backend/loc/loc_node.py` - receive raw data (RSSI data) forward by `dbapi` and filter the  raw data by last digit of the associated MAC address. ex. (0-7) goes to `loc1` and (8-F) goes to `loc2`. We need to add new function to filter specific MAC by creating a white list.  
4. `/home/xuyi/paradrop/trunk/backend/loc/loc.py` - the sever that process and compute the raw data from `loc_node` then sent computed data back to `dbapi_server` and store there.
5. 


## Study Notes: 
1.in side the `loc_node.py` file, function `generateMacMap` generates a dictionary `macMap` that map `last char of MAC` to `loc id number`

2.`macMap` takes `char` and returns `loc id number`


3.`locData` is a dictionary where key(might be `number`) -> value (might be `data`)

4.`locMap` should be a dictonary of mapping from `loc number`: `data`

`locMap` -> {0:[data1, data2, data3...], 1:[data1, data2, data3..], 2:[d1, d2..] ...}

5.`determineLoc(macMap, d)` returns  `macMap[d[2][-1]]` which is a `loc id numnber`, 

6.Get MAC address: `d[2]`

7.Get the last char of MAC address: `d[2][-1]`

8.Use the last char of MAC to get its `loc id num`: `macMap[d[2][-1]]`

9.`defer_parseData` function inside `loc_node.py` is the method send `data` to specific `loc module`, have a white list filter MAC address here will be reasonable.

10.`myLocData` = `locData`, `locData` stores the information of the current `loc` inlclude the number of loc modules is running. 

11.`genearteMacMap`'s primary function is to divide 0-F 16 possibles of last char of the MAC address into number of group to do computation. That number determine by current number of running `loc module`(determine by `myLocData`)



cat scripts/recon_loc.conf 
python scripts/recon_locmgmt.py -g "State Street" --check

svn status

svn ci -m "DFW: added password support to SSID startup"


## Questions: 
1. Can I run command under xuyi@paradrop.wings? will that mess with the current system  - yes, run with diffrent port to not mess with the current PROD system.

2. what is the command to create `loc` and `loc_node` with configuration file `recon_loc.cnf` ?

3. `locData`?? format ??  - `locData` stroes infomation about the current running `loc` instance, `len(locData.keys())` return the number of currnt running loc instance. 

4. does d[2] detach the MAC adress from the data?  yes
5. How will the MAC address be imported to the WHITELIST?? 
 
## Testing: 

open multiple tabs for running `loc_server`, `loc_node`,`loc`  

[detail wiki here](http://wirelessathome.wings.cs.wisc.edu/redmine/projects/paradrop/wiki/Recon_Localization)

**0.Run dbapi:**  

In some cases you might want to test the FULL end to end system which would include the dbapi, in this case you can run dbapi as follows:

`python dbapi/dbapi_server.py -s DBAPI_RECON_SNIFF_DISABLE_DB:True -s LOC_SERVER_URL:http://localhost`

If you deceide to run the test  on **paradrop.wings**, make sure you change the `LOC_SERVER_PORT` for `loc_sever`, `loc_node`, and `loc` first so that it will not interference with current `loc_node` for PROD (current PROD version of the loc_server runs on 10400). To change port for `local_server`, append command line: `-s LOC_SERVER_PORT:PORT_NUM`

**1.Run `loc_server`:**  

On local machine:

	python loc_server.py -s LOC_SERVER_DISABLE_DB:True

On `paradrop.wings`: (change to port other than 10400)
	
	python loc_server.py -s LOC_SERVER_DISABLE_DB:True -s LOC_SERVER_PORT:11400
	

**2.Run `loc_node`:**  

On local machine:

	python loc_node.py -g "Test" --id 0 -s LOC_SERVER_URL:http://localhost -s LOC_NODE_URL:http://localhost

On `paradrop.wings`: 

	python loc_node.py -g "Test" --id 0 -s LOC_SERVER_URL:http://localhost -s LOC_NODE_URL:http://localhost -s LOC_SERVER_PORT:11400
	
**3.Run two instanc of `loc`:**  

On local machine:

Instance 0:  
	python loc.py --id 0 -g "Test" --guarantee 8 -s LOC_SERVER_URL:http://localhost -s LOC_URL:http://localhost

Instance 1:  
	python loc.py --id 1 -g "Test" --guarantee 8 -s LOC_SERVER_URL:http://localhost -s LOC_URL:http://localhost
	
OR

On `paradrop.wings`: 

python loc.py --id 0 -g "Test" --guarantee 8 -s LOC_SERVER_URL:http://localhost -s LOC_URL:http://localhost -s LOC_SERVER_PORT:11400


**The loc_test**  

If testing **directly with loc_node** (ie. loc_test bypasses dbapi and sends the raw data directly to loc_node)

`python loc_test.py -g "Test" -t 5 -ep 0.10 -np 0.10 -mp "10-0.85-0.99-0.5" -u "http://localhost:10500/v1/data" 
`

If testing **full end to end with dbapi** which means loc_test acts like a true AP and sends its data only to dbapi

`python loc_test.py -g "Test" -t 5 -ep 0.10 -np 0.10 -mp "10-0.85-0.99-0.5" -u "http://localhost:10330/v1/recon/data/set" `


## Useful Functions:
### zip()
listOfMac = ['A','B','C','D']  
listOfNum = [1,2,3,4]  
zip(listOfMac, listOfNum) = [('A', 1), ('B', 2), ('C', 3), ('D', 4)]  

### grep

grep file named `sniff.py` in current directory:
  
`grep -rl "sniff.py" .`

`-r` - (or `--recursive`)indicates search recursivly
`-l` - (or `--files-with-matches`) only print files name of matching files 




## Potential Solution

inside the `loc_node.py`, utilize the  `def filterData(self, d):` function.

```
WHITELIST_MAC = ['2a:e3:5a:8b:38:cf', '94:81:90:f9:2f:fc', '71:b7:4b:54:8e:ec', '8a:1a:27:0c:55:f6']

```

```
def filterData(self, d):
    """Filter some data, if we return true here then skip this data"""
	....
	if d[2] not in WHITELIST_MAC:
    	return True
    	
    retur False
    
```

```
def setupArgParse():
    ...
    p.add_argument('--whitelist', '-wl', help='create MAC white list. usage: -wl "mac0" -wl "mac1"... ', type=str, action='append', required=False)
    ...
```

```

# Main function
if(__name__ == "__main__"):
    ...
    
    if(args.whitelist):
        WHITELIST_MAC = args.whitelist
    ...
    
```



## Errors encoutered:


x86_64-linux-gnu-gcc: internal compiler error: Killed (program cc1)

Please submit a full bug report,

with preprocessed source if appropriate.

See <file:///usr/share/doc/gcc-4.8/README.Bugs> for instructions.

error: command 'x86_64-linux-gnu-gcc' failed with exit status 4

----------------------------------------
Cleaning up...
Command /usr/bin/python -c "import setuptools, tokenize;__file__='/tmp/pip_build_root/pandas/setup.py';exec(compile(getattr(tokenize, 'open', open)(__file__).read().replace('\r\n', '\n'), __file__, 'exec'))" install --record /tmp/pip-6NVncg-record/install-record.txt --single-version-externally-managed --compile failed with error code 1 in /tmp/pip_build_root/pandas
Traceback (most recent call last):
  File "/usr/bin/pip", line 9, in <module>
    load_entry_point('pip==1.5.4', 'console_scripts', 'pip')()
  File "/usr/lib/python2.7/dist-packages/pip/__init__.py", line 235, in main
    return command.main(cmd_args)
  File "/usr/lib/python2.7/dist-packages/pip/basecommand.py", line 161, in main
    text = '\n'.join(complete_log)
UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 41: ordinal not in range(128)

-----------------------------------------
### Solutions:  

[Solution from stackoverflow](http://stackoverflow.com/questions/24455238/lxml-installation-error-ubuntu-14-04-internal-compiler-error)


Possible solution (if you have no ability to increase memory on that machine) is to add swap file.

`sudo dd if=/dev/zero of=/swapfile bs=1024 count=524288`  
`sudo chmod 600 /swapfile`  
`sudo mkswap /swapfile`  
`sudo swapon /swapfile`   
from https://github.com/pydata/pandas/issues/1880#issuecomment-9920484

This worked for me on smallest digital ocean machine




## Schedule: 

1.white list for MAC address in `loc_node`  (finsih code on JUN 24th)
  white list for MAC address in `loc_node` (testsed on JUN 26th)

2.The next thing we need to do is add the ability for the createWiFi command to store the AP configuration in our database and then when sniff.py download's its settings it would start the AP during initialization if those settings are found in the database.

So there are several things that need to change:

