

## Packet Structure:
![Packet Format]
(http://pages.cs.wisc.edu/~xuyi/myBlog/640g1.jpg)

- pkt_type (8bit)
- seq_num (32bit)
- int len (32bit)


## Blaster (client) - connect()
### Parameter: 
- hostname (client) 
- port (client)
- rate (send rate)
- num (# of packet)
- seq_no (arbitary choice 32bit)
- length (length of payload)
- echo (tell blaster if should expect echo from blastee)

### functionality: 
- [ ] each sent pkt prints `seq num`, `first 4 bytes of payload` into `STDOUT`
- [ ] prints `label: echo`, `seq #`, `first 4 bytes of payload`

## Blastee (server) (bind())
### Parameter:
- port (port that blastee run)
- echo (tell blastee if should echo back exact packet with (char 'C') back to blaster)


### functionality: 
- [ ] 







### ISSUEs: 
1. wrap around of sequence number
2. 


###  C

`sizeof(char *)` is the size of the pointer, so normally 4 for 32-bit machine, and 8 for 64-bit machine.

`sizeof` an array, on the other hand, outputs the size of the array, in this case, 20*sizeof(char) = 20


## Resource: 
[Socket Programming - UDP & TCP](http://www.cs.dartmouth.edu/~campbell/cs60/socketprogramming.html)