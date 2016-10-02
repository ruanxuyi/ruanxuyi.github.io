title: "Lintcode 60 - Search Insert Position"
date: 2016-06-28 11:59:15
tags:
- BinarySearch
- LintCode
---

[Search Insert Position](http://www.lintcode.com/en/problem/search-insert-position/)  

# Code: 
```java
public int searchInsert(int[] A, int target) {
        // write your code here
        if (A.length == 0 || target < A[0]) {
            return 0;
        }
        // binary search;
        // IDEA: not find the exact pos of the target
        // Correct IDEA: find the first element that is larger than the target, 
        // mark it as `end`, (if target larger than the last element in array, 
        // keep `end` to the last element). 
        // IDEA -> try to norrow down to a regiion of possible place to insert 
        // the target. 
        // Possible place examples: 
        // [1, 4, 5, 6, 7, 9] -> possible place [7(start), 9(end)] target = 8
        // [1, 4, 5, 6, 7, 9] -> possible place [7(start), 9(end)] target = 10
        int low = 0;
        int mid = 0;
        int high = A.length - 1;
        //int mid = low + (high - low) / 2; 这一行可以弄到下面去
        while (low + 1 < high) { // to keep `start` and `end` seperate.
            mid = low + (high - low) / 2;
            if (target < A[mid]) {
                high = mid;
            } else if (target > A[mid]) {
                low = mid;
            } else {
                return mid;
                //可能会有读者认为刚开始时就要判断相等，但毕竟数组中不相等的情况更多  
                //如果每次循环都判断一下是否相等，将耗费时间 
            }
        }
        // both if statements have `=` because (low + 1 < high) jump out before 
        // evaluate if (target == A[mid]) {

        if (target <= A[low]) {
            // if target value is smaller than the smallest value in array
            return low;
        } else if (target <= A[high]) {
            // if target value is in between low and high
            return high;
        } else { 
            // if target larger than the largest element in array
            return high + 1;
        }
    }
```
<!--more-->

# Description: 

Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You may assume **NO duplicates** in the array.

**Example**: 

`[1,3,5,6]`, 5 → 2  

`[1,3,5,6]`, 2 → 1  

`[1,3,5,6]`, 7 → 4  

`[1,3,5,6]`, 0 → 0  



# Thought Process: 
- binary search algorithm  
- return found target index inside BS algorthm  
- BS algorithm fails to capture the target if the target value fall right into either `low` or `high` index and leave `while` loop.  
- Further evaluate if target value match `low` or `high` index.  
- need to **insert** into **corresponding index** location if target value not exist in the current array.  
```
	[ * |low| * |high| * ]   
	* indicate possible place to insert
```  

# Corner Case:
- if target smaller than first element in array, insert it into index 0.  
- 
