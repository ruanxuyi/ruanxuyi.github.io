title: "LC129 - rehashing"
date: 2017-01-06 13:58:16
tags:
- LintCode
- DataStructure
- HashTable
---


## <center> description </center>

The size of the hash table is not determinate at the very beginning. If the total size of keys is too large (e.g. `size >= capacity / 10), we should double the size of the hash table and rehash every keys. Say you have a hash table looks like below:

`size=3, capacity=4`

```
[null, 21, 14, null]
       ↓    ↓
       9   null
       ↓
      null
```

The hash function is:

```java
int hashcode(int key, int capacity) {
    return key % capacity;
}
```

here we have three numbers, `9`, `14` and `21`, where `21` and `9` share the same position as they all have the same hashcode 1 (`21 % 4 = 9 % 4 = 1`). We store them in the hash table by linked list.

rehashing this hash table, double the capacity, you will get:

`size=3, capacity=8`

```
index:   0    1    2    3     4    5    6   7
hash : [null, 9, null, null, null, 21, 14, null]
```

Given the original hash table, return the new hash table after rehashing .

 **Notice**  

For negative integer in hash table, the position can be calculated as follow:

C++/Java: if you directly calculate `-4 % 3` you will get `-1`. You can use function: `a % b = (a % b + b) % b` to make it is a non negative integer.
Python: you can directly use -1 % 3, you will get 2 automatically.

**Example**  
Given `[null, 21->9->null, 14->null, null]`,

return `[null, 9->null, null, null, null, 21->null, 14->null, null]`

[LC129 rehashing](http://www.lintcode.com/en/problem/rehashing/)

## <center> code </center>

```java
/**
 * Definition for ListNode
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    /**
     * @param hashTable: A list of The first node of linked list
     * @return: A list of The first node of linked list which have twice size
     */    
    public ListNode[] rehashing(ListNode[] hashTable) {
        // write your code here
        int capacity = hashTable.length;
        if (capacity == 0) {
            return hashTable;
        }
        // new hashtable w/ 2x size
        ListNode[] rehash = new ListNode[2*capacity];
        int capacity_rehash = rehash.length;
        
        for (ListNode hash : hashTable) {
            while (hash != null) {
                int key = hash.val;
                int index_rehash = hashcode(key, capacity_rehash);
                if (rehash[index_rehash] == null) {
                    rehash[index_rehash] = new ListNode(key);
                } else {
                    // chaining
                    ListNode tmp;
                    tmp = rehash[index_rehash];
                    while (tmp.next != null) {
                        tmp = tmp.next;
                    }
                    tmp.next = new ListNode(key);
                }
                // traverse current chaining
                hash = hash.next;
            }
        }
        return rehash;
    }
    int hashcode(int key, int capacity) {
        return (key % capacity + capacity) % capacity;
    }
};
```

<!--more-->

## <center> algorithm correctness </center>

## <center> complexity analysis </center>
The rehashing take $O(n)$ time complexity where $n$ is the number of exisiting itmes to rehash all the exisiting items to a new hashTable with larger size.   

## <center> self notes </center>
## <center> application </center>
## <center> reference </center>
