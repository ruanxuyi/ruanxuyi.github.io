tux-43:~/cs552$ scp xuyi@best-linux.cs.wisc.edu:/u/k/a/karu/courses/cs552/spring2013/handouts/bins/* ~/cs552/bins/

Change abs address in `vcheck-all.sh`,  and `vcheck.sh` files.

Modify `vcheck-all.sh`:

```
/userspace/x/xruan/cs552/bins/vcheck.sh $a $outfile;
```

Modify `vcheck.sh`: 


```
scp xuyi@best-linux.cs.wisc.edu:/u/k/a/karu/public/html/courses/cs552/spring2013/handouts/verilog_code
```

Edit your `.bashrc` file

```
tux-43:~$ cd ~
tux-43:~$ vim .bashrc 
```

add following to the end

```
export MGC_HOME=/s/mentor/MGC_HOME-2004
export SDD_ROOT=/s/mentor
export SDD_HOME=/s/mentor/2004
export ADK=/s/mentor/adk
export MGC_WD=$HOME/mentor
export MGC_LOCATION_MAP=$HOME/mentor/.location
export MGLS_LICENSE_FILE=/s/mentor/etc/cust/mgls/mgc.licenses
export PATH=$PATH:/s/mentor/bin:/s/mentor/MGC_HOME-2004/bin:/s/mentor/adk/bin:/** your abs address for bins folder on cae**/

```


From your home directory  
```
tux-43:~$ mkdir mentor
tux-43:~$ cd mentor/
```

Copy `.location` file from cs server:   
```
tux-43:~/mentor$ scp xuyi@best-linux.cs.wisc.edu:/u/k/a/karu/courses/cs552/spring2013/downloads/.location .location
```
`.location` file is hidden  

`ls -la` to check hidden file.

Modify `.location` file:  
 



`wsrun.pl`
