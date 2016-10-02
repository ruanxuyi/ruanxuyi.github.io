title: "LintCode 14 - First Position of Target"
date: 2016-07-01 11:16:34
tags:
- BinarySearch
- LintCode
---

[First Position of Target](http://www.lintcode.com/en/problem/first-position-of-target/)  

# Code: 
```java
    public int binarySearch(int[] nums, int target) {
        //write your code here
        // dupliacte, first index, high = mid
        if (nums == null || nums.length == 0) {
            return -1;
        }
        int low = 0;
        int mid = 0;
        int high = nums.length - 1;
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (target <= nums[mid]) {
                high = mid;
            } else {
                low = mid;
            }
         }
         if (nums[low] == target) {
             return low;
         } else if (nums[high] == target) {
             return high;
         } else {
             return -1;
         }
    }
```
<!--more-->

# Description: 

For a given sorted array (ascending order) and a `target` number, find the first index of this number in `O(log n)` time complexity.

If the target number does not exist in the array, return `-1`.

**Example**
If the array is `[1, 2, 3, 3, 4, 5, 10]`, for given target `3`, return `2`.

# Thought Process: 
- **binary search** algorithm + **duplication** allowed.  
- need to return the index of the **first** meet target value.`target <= nums[mid]` with `high = mid`.  


# Corner Case:
- `nums == null || nums.length == 0`