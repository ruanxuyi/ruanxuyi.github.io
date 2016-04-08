 什么时候用arraylist？》
[linked list LRU leetcode example](http://www.cnblogs.com/feiling/p/3426967.html)

## Algorithm - List Interface

### ArrayList and LinkedList interface from List.

`ArrayList` use array as fundemental data structure. The array used to store data is dynamic changing (copy the current array to a new double size array) when free space in array reach certain threshold. 
 

 
`LinkedList` use LinkedNode (previous, next, value) as base structure.
- use when frequent insert and delete. 
- 




### Question: How to find a data (delete operation) in a list? 

### Thing to ask before coding: 
1. Size of the list:

1) if hte size of list is small, use treverse the whole list.  
2) if the size of the list is large (which is usually the case), we need to come up something more efficient. (however, it is a very childish idea to put a lot of data in a list if known that data size is significant, maybe putting all data in database and using database query is a smarter way.)

2. Input validation
1) check if the `head node` is null.

3. Corner cases: 
1) if the target delete value the head/tail node.


4. Others:
1) is the list is in-order? (maybe not very usefull in linked list, but useful when binary search can apply)
2) if duplicated of elements allow?
3) single linked list? 


### Leetcode #203 & 237


Potential Solution: 

1. 这个说的最在理，不要去怀疑面试官的问题的合理性，而是去想思路去解决它我的方案是多线程分段扫描，并且共用一个volatile boolean型的信号，初始为true，当这个信号为true的时候会继续查找下一个，一旦有线程找到，立马将该信号置为false，所有的线程便戛然而止



[when to use LinkedList](http://www.jdon.com/36091)  
[Look for data inside within a list](http://www.debugease.com/j2se/3508653.html)


