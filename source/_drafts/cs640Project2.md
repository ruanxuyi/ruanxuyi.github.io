IPv4 comes in -> from one of the router's interface.
It wants to go to IP_A -> check ARP table see if match: 
	Y: get dest_mac for IP_A, modify Ethernet header
	N: push into IP_queue-> bitwise AND->send out Arp request @ enterface ->
		Arp request info: sender_mac = interface_mac (by next_hop_ip query from interface info.), sender_ip = next_hop_ip (info from Forward Table) 
		send out ARP request

Receive ARP query -> cache <dst_ip: dst_mac> into ARP table -> modify ethernet Header -> send the IP packet to the dest_mac.



Test case: 
1. if ARP table has a match in entry.
2. test no match with forward table