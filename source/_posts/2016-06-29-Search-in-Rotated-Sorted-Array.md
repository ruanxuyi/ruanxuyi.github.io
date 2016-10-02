title: "LintCode 62 - Search in Rotated Sorted Array"
date: 2016-06-29 10:07:47
tags:
- BinarySearch
- LintCode
---

[Search in a Big Sorted Array](http://www.lintcode.com/en/problem/search-in-a-big-sorted-array/)  


# Code: 

```java 
    public int search(int[] A, int target) {
        // write your code here
        if (A == null || A.length == 0) {
            return -1;
        }
        int low = 0; 
        int mid = 0;
        int high = A.length - 1;
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (A[mid] == target) {
                return mid;
            } else if (A[low] < A[mid]) {
                // low -> mid in order
                if (target < A[mid] && target >= A[low]) {
                    high = mid;
                } else {
                    low = mid;
                }
            } else {
                // mid -> high in order
                if (target > A[mid] && target <= A[high]) {
                    low = mid;
                } else {
                    high = mid;
                }
            }
        }
        if (A[low] == target) {
            return low;
        } else if (A[high] == target) {
            return high;
        } else {
            return -1;
        }
    }
```

<!--more-->

# Description: 
Suppose a sorted array is rotated at some pivot unknown to you beforehand.

(i.e., `0 1 2 4 5 6 7` might become `4 5 6 7 0 1 2`).

You are given a target value to search. If found in the array return its index, otherwise return -1.

You may assume no duplicate exists in the array.  

**Example**  
For `[4, 5, 1, 2, 3]` and `target=1`, return `2`.

For `[4, 5, 1, 2, 3]` and `target=0`, return `-1`.  



# Thought Process: 
- binary search  
- no duplicate allowed  
- rotated array: mid index seperate the array into two parts.  
- at least one part still in-order  
- 1.Find the part in-order first  
- 2.since it is in order, we can check if target value exist in that range  
- 3.if in that range, then set appropriate index, else the target must be in the other part of the array OR it does nit exist  
- 4.continue apply binary search to the new halfed array  


# Corner Case:
- `2 1` only two element, catch by the finally statemnt  
- size 0 or 1 array  
