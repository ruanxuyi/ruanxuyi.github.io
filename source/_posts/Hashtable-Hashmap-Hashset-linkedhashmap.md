title: Hashtable vs Hashmap vs Hashset
date: 2016-03-25 14:35:52
updated: 2016-03-25 14:35:52
tags: 
- HashTable
- HashMap
- HashSet
categories: DataStructure

---


# **HashTable, HashMap, HashSet**


| HashTable | HashMap | HashSet |
|-----------|---------|---------|
| synchronized | not synchronized|not synchronized |
| duplicate key allow | duplicate key allow | duplicate key *NOT* allow|
|  null keys or values NOT allow | allows one null key & many null values|allow one null value|
| key, value pair| key, value pair| non-duplicate value|
| implement Map interface | implement Map interface| implement Set interface|


<!--more-->


# **HashMap**

## **Internal Data Structure**

There are two types of internal data structure in Java programming. *Array* and *linked-list*. 

*Array*'s query can complete in constant time, however, operations such as add or remove certain elements result large overhead (rearranging elements within array). 

On the other hand, *linked-list* has huge overhead in query (treverse whole linked-list) however, the pure operation of add/delete in *linked-list* data structure (by maniuplating the pointer) is much easier comparing to *array*. 

HashMap/Table combines both constant query time from *array* and relatively better performance for add/delete with *linked-list* 

Below is a graphical represetation of a Hashtable.

![HashMap internal data structure](http://img.my.csdn.net/uploads/201211/17/1353118778_2052.png)

As more and more *key value* pair 'put' into the hash table. It is very likely that different key values will result into the same location of the arrray cell - which is also called **collision**.  

There are two types of solution for collision:   
- chain buckets (memory overhead, external datastructure)
- open addressing (no extra memory overhead, hashtable itself)

A chain bucket was implemented with *linked-list*. As the number of collisions into the same array cell increased, the time to treverse the *linked-list* to look for the specified *key* value will increase. Once the size of the chain-bucket linked-list exceeds the *threadshold* ( threadshold = capacity * loadFactor). The size of the capacity (size of array) will increase from default capacity of 16 to 32 to reduce the overhead of treverse the long *linkedlist*. 

> Open addressing strategy requires, that hash function has additional properties. In addition to performing uniform distribution, it should also avoid clustering of hash values, which are consequent in probe's order.
[read here for detail](http://www.algolist.net/Data_structures/Hash_table/Open_addressing)


## **Characterstics**

Compared to *HashTable*, *HashMap* has the following special characters: 

**1. permit nulls**  

Null value is allowed for both *key* and *value* in *hashMap*, while that is not allowed in *hashTable*. There is only **one** `key=null` is permited in *hashMap*, while **multiple** `value=null` is allowed. Becaue of that, `get(Object key)` should not be used to determine whether *key* exists in a table since a `<key, null>` pair is legal in *hashMap*.


**2. Unsynchronized in multi-thread**

*HashMap* implementation of hash table is not thread safe. Manual steps are needed to ensure thread safe in multiple threads environment. The simplest way to enusre thread-safe is by warpping with `Collections.synchronizedMap` method at the create time: 


```
 Map m = Collections.synchronizedMap(new HashMap(...));
```

The wrapping at *creatation time* prevent accidental unsynchronized behavior in multi-thread contest. 


* *Why collections class provide synchronized behavior???*

According to java documentation: 

> The synchronization wrappers add automatic synchronization (thread-safety) to an arbitrary collection. Each of the six core collection interfaces — *Collection, Set, List, Map, SortedSet, and SortedMap*

```java
public static <T> Collection<T> synchronizedCollection(Collection<T> c);
public static <T> Set<T> synchronizedSet(Set<T> s);
public static <T> List<T> synchronizedList(List<T> list);
public static <K,V> Map<K,V> synchronizedMap(Map<K,V> m);
public static <T> SortedSet<T> synchronizedSortedSet(SortedSet<T> s);
public static <K,V> SortedMap<K,V> synchronizedSortedMap(SortedMap<K,V> m);
```

In example above, we use `synchronizedMap` in for one of the collection interface: Map with collection wrapper to ensure thread-safe ability for HashMap .

## **Performance**

**1. constant time operation for `get()` and `put()` operation.**  


**2. *initial capacity* and *load factor* affect the performance of HashMap.**     

* The *capacity* is the number of buckets in the hash table. Therefore the *initial capacity* is the number of bucekts in the hash table when created. *load factor* determines how full the hash table is allowed bofore its capacity is automatically increased. When number of entries exceeds `capacity * loadfactor`, the hash table is *rehashed*.  

* Rule of thumb: the default load factor (.75) offers good tradeoff between time and space costs. For example, if known large amount of entries need to store into hash table, it will be more efficient to create a large capacity instead of performing automatic rehashing as needed. 


## **Constructors**


| Constructor Summary | 
|---------------------|
| `HashMap()` - default initial capacity(16) and default load factor(.75) | 
|`HashMap(int initialCapacity)` - Constructs an empty HashMap with the specified initial capacity and default load factor(.75)|
|`HashMap(int initialCapacity, float loadFactor)` - Constructs an empty HashMap with the specified intial capacity and load factor|



## **Methods**

- `clear()`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Remove all mappings from this map.


- `put(K key, V value)`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Assoicate the specified *value* with the specified *key* in this map.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Return   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. the *value* previously assoicated with the *key* OR   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. `null` if *key* not exists in the table before. 

- `get(Object key)`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Return the value of the corresponding key, or return `null` if:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. key not exists in the map  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. if the value of the key is `null`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Therefore we cannot use `get()` to determine if key exist in the haspmap, we should use `containsKey()` to check.   


- `containsKey(Object key)`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Return `true` if this map contains a mapping for the specific key.   

- `containsValue(Object value)`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Return `true` if this map contains a mapping for the specific value.   


- `isEmpty()`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Return ture if this map contains no key-value pair.


 - `remove(Object key)`

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Removes the mapping for the specified key from this map if present.
 
- `size()` 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns the number of key-value mappings in this map.  

-------------------------------------less use -----------------------------------------



- `values()`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns a `Collection<V>` view of the values contained in this map.
 

- `Set<K>	keySet()` 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns a Set view of the keys contained in this map.

- `Object	clone()` 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.


- `Set<Map.Entry<K,V>>	entrySet()`  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns a Set view of the mappings contained in this map.


# **HashTable**

>Hashtable is basically a datastructure to retain values of key-value pair.  

>+ It didn’t allow null for both key and value. You will get NullPointerException if you add null value.  
+ It is synchronized. So it comes with its cost. Only one thread can access in one time.

```java
Hashtable<Integer,String>; cityTable = new Hashtable<Integer,String>();
cityTable.put(1, "Lahore");
cityTable.put(2, "Karachi");
cityTable.put(3, null); /* NullPointerEcxeption at runtime*/
 
System.out.println(cityTable.get(1));
System.out.println(cityTable.get(2));
System.out.println(cityTable.get(3));

```
# **HashSet**

>HashSet does not allow duplicate values. It provides add method rather put method. You also use its contain method to check whether the object is already available in HashSet. HashSet can be used where you want to maintain a ***unique list***.

```java
HashSet<String> stateSet = new HashSet<String>();
stateSet.add ("CA");
stateSet.add ("WI");
stateSet.add ("NY");
 
if (stateSet.contains("PB")) /* if CA, it will not add but shows following message*/
     System.out.println("Already found");
else
    stateSet.add("PB");
```

## Reference

[Java Documentation](https://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html)  
[HashMap internal data structure](http://blog.csdn.net/tgxblue/article/details/8479147)  
[Collection Wrapper](https://docs.oracle.com/javase/tutorial/collections/implementations/wrapper.html)  
[Markdown Indentation](http://stackoverflow.com/questions/6046263/how-to-indent-a-few-lines-in-markdown-markup)
[Markdown excerpt](http://www.jianshu.com/p/q81RER)  
[hasmap VS hashset VS hashtable](https://www.quora.com/What-is-the-difference-between-HashSet-HashMap-and-hash-table-How-do-they-behave-in-a-multi-threaded-environment)  
[HashMap vs Hashtable vs HashSet](http://www.pakzilla.com/2009/08/24/hashmap-vs-hashtable-vs-hashset/)  

