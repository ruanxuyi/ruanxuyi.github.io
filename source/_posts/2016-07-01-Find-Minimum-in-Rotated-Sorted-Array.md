title: "LintCode 159 - Find Minimum in Rotated Sorted Array"
date: 2016-07-01 11:38:06
tags:
- BinarySearch
- LintCode
---


[Find Minimum in Rotated Sorted Array](http://www.lintcode.com/en/problem/find-minimum-in-rotated-sorted-array/)  

# Code: 
```java
    public int findMin(int[] num) {
        // write your code here
        if (num == null || num.length == 0) {
            return -1;
        }
        int low = 0;
        int mid = 0;
        int high = num.length - 1;
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (num[low] > num[mid]) {
                high = mid;
            } else if (num[high] < num[mid]) {
                low = mid;
            } else {
                // un-rotated?? 需要考虑么?
                return num[low];
            }
        }
        if (num[low] < num[high]) {
            return num[low];
        } else {
            return num[high];
        }
    }
```
<!--more-->

# Description: 

Suppose a sorted array is rotated at some pivot unknown to you beforehand.

(i.e., `0 1 2 4 5 6 7` might become `4 5 6 7 0 1 2`).

Find the minimum element.

> **Notice**:  
> You may assume no duplicate exists in the array.


**Example**  
Given `[4, 5, 6, 7, 0, 1, 2]` return `0`


# Thought Process:
- binary search algorithm  
- **no** **target** values given  


`7 8 0 **1** 2 3 4 5` -> 

```java
if (num[low] > num[mid]) {
                high = mid;
```

`4 5 6 7 **8** 9 0 1 2` -> 

```java
if (num[high] < num[mid]) {
                low = mid;
```

` 2 3 4 5 6 7 8` -> unrotated 
 
```java 
	return num[low];
```
# Corner Case:
- `num == null || num.length == 0` 