title: "CTCI-notes"
date: 2017-08-24 13:54:26
tags:
- tag1
- teg2
---


# Data Structures

## Hash Tabes

### 1. Array of linked lists  

**Time Complexity:**  
- insert, delete, search $O(1)$ average, $O(N)$ worst case  
**Space Complexity:**  
- Array $O(size of array)$ + linked list $O(N)$  
**Others:**  
- copy on resize  
- wasting space on empty index  

### 2. Binary Search Tree

**Time Complexity:**  
- $O(logn)$ for insert, delete, search  
**Space Complexity:**  
- Size of BST itself $O(N)$   
**Others:**  
- NO resize  
- NOT wasting space on empty index  
- Benefit of ordering  


### 3. Array of binary search trees

**Time Complexity:**  
- insert, delete, search $O(1)$ average, $O(logn)$ worst case  
**Space Complexity:**  
- Array $O(size of array)$ + Size of BST itself $O(N)$   
**Limitation:**  
- BST requires hash table elements have an **order**.  
**Others:**  
- theoritically, BST is better than linked list, in real world situation, BST bring nothings to the hash table, which is why poor performance of a list is acceptable.  
- extra complexity into implementation (need to consider **ordering** compare to linked list)  
- `HashMap` in Java 8 uses array + BST for hash table  

##s# Summary:
- array always need to consider resize complexity  
- BST ordering if benefit  
- BST requires hash table elements have an **order**.  
ref: [https://softwareengineering.stackexchange.com/questions/280762/is-it-possible-to-speed-up-a-hash-table-by-using-binary-search-trees-for-separat](https://softwareengineering.stackexchange.com/questions/280762/is-it-possible-to-speed-up-a-hash-table-by-using-binary-search-trees-for-separat)

TODO:
String builder implementation
https://codereview.stackexchange.com/questions/73526/implement-stringbuilder


## Stacks and Queues

### Stack


### Queue
