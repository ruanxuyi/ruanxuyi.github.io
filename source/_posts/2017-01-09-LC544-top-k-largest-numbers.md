title: "LC544 top k largest numbers"
date: 2017-01-09 15:48:23
tags:
- LintCode
- DataStructure
- Sorting
- DualPivotQuicksort 
---


## <center> description </center>

Given an integer array, find the top k largest numbers in it.

**Example**
Given `[3,10,1000,-99,4,100]` and `k = 3`.
Return `[1000, 100, 10]`.

[LC544 top k largest numbers](http://www.lintcode.com/en/problem/top-k-largest-numbers/)

## <center> code </center>

```java
class Solution {
    /*
     * @param nums an integer array
     * @param k an integer
     * @return the top k largest numbers in array
     */
    public int[] topk(int[] nums, int k) {
        // Write your code here
        int len = nums.length;
        if (len < k) {
            return nums;
        }
        Arrays.sort(nums);
        int[] sol = new int[k];
        for (int i = 0; i < k; i++) {
            sol[i] = nums[len - 1 - i];
        }
        return sol;
    }
};
```
<!--more-->

## <center> algorithm correctness </center>

## <center> complexity analysis </center>

**Time**: Default sorting algorithm `Arrays.sort()` in Java is a Dual-Pivot Quicksort, which offer $O(nlogn)$ for most of the data set.  

> Dual-Pivot Quicksort is typically faster than one pivot quicksort.  

TODO: [Dual Pivot Quicksort]()

**Space**: $O(1)$.

## <center> self notes </center>
- TODO: Dual Pivot Quicksort

## <center> application </center>
## <center> reference </center>
