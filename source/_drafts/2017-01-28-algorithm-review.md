title: "algorithm review"
date: 2017-01-28 20:13:48
tags:
- Algorithm
---

# Data Structure

## Array
- add or delete $O(n)$  
- fast access/modify $O(1)$  
- **fixed** size after initialization  
- `Arrays.sort()` implemtation (two-pivot QS)  
- modify `Arrays.sort()` to support genric type `<E>` with `Comparator`

```java
Arrays.sort(arrayToSorted, new Comparator<E>() {
	public int compare(E e1, E e2) {
		return e1.val - e2.val;
	}
});
```
- Java Implementation

```java
int len = 10;
int[] intArray = new int[len];
int[] intArray2 = new int[]{1,2,3,4,5};
// generic type array
E[] genicArray = new E[];

```

## LinkedList
- dummy node  
- fast slow pointers  
- reverse linked list  
- reverse second half  
- copy linked list  
- Java Implementation  

```java
class ListNode {
	int val;
	ListNode next;
	public ListNode(int val, ListNode next) {
		this.val = val;
		this.next = next;
	}
}
```


## Doubly Linked List
- both `prev` and `next` pointers  
- Java Implementation:  

```java
class DoubleListNode {
	int val;
	doubleListNode prev;
	doubleListNode next;
	
	public DoubleListNode(int val, DoubleListNode prev, DoubleListNode next) {
		this.val = val;
		this.prev = null;
		this.next = null;
	}
}
```

## Queue
- FIFO  
- **Opeartions**: `offer()`, `poll()`, and  `peek()`

```java
import java.util.Queue;

Queue<E> queue = new Queue<E>();
queue.offer();
queue.pool();
queue.peek();
```

[java queue doc](https://docs.oracle.com/javase/7/docs/api/java/util/Queue.html)

## Stack
- LIFO  
- **Opeartions**: ~~`put()`~~ `push()`, ~~`get()`~~ `pop()`, ~~`is`~~`empty()`, and  `peek()`  
- Java Implementation:  

```java
import java.util.stack;

Stack<E> stack = new Stack<E>();
stack.push();
stack.pop();
stack.empty();
stack.peek();
```
[java stack doc](https://docs.oracle.com/javase/7/docs/api/java/util/Stack.html)
## Hash Table

- $O(1)$ access time  
- `<key, value>` pair  
- Array + LinkedList  
- HashSet count odd/even number of elements in array.
- Java Implementation:  

```java
import java.util.HashMap;

HashMap<K, V> map = new HashMap<K, V>();
~~map.add(K key, V val);~~
map.put(K key, V val);
map.containsKey(K key);
map.containsValue(V val);
map.isEmpty();
// to remember
map.remove(K key);
map.entrySet(); // returns set view of mappings(<k, V>)
map.keySet(); // returns set view of keys {k1, k2, ...}  
map.size();
map.clear();  remove all mappings from map

```

## Binary Tree
- Tree w/ two children  
- Java Implementation
- 
```java
class TreeNode {
	int val;
	TreeNode left;
	TreeNode right;
	public TreeNode(int val, TreeNode left, TreeNode right) {
		this.val = val;
		this.left = left;
		this.right = right;
	}
} 
```


## Binary Search Tree
- Tree w/ two children  
- left child smaller than root, right child larger than root.  


## Priority Queue
- priorityQueue default minQueue  
- change `Comparator` for maxQueue  



### Operations

### Operation Complexity

### Implementation

#### Comparator

```java
import java.util.PriorityQueue;

PriorityQueue<E> pq = new PriorityQueue<E>(initCapacity, new Comparator<E>() {
	public int compare(E e1, E e2) {
		return e2.val - e1.val; // maxQueue
	}
});

```	

## Trie
- prefix based search  
- require less space than hashmap

## Suffix Tree