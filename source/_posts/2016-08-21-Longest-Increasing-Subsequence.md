title: "LintCode 76 - Longest Increasing Subsequence"
date: 2016-08-21 11:49:07
tags:
- LintCode
- DP
- H
- BinarySearch
---

[Longest Increasing Subsequence](http://www.lintcode.com/en/problem/longest-increasing-subsequence/#)

# Code: 

## DP Approach

```java

public class Solution {
    /**
     * @param nums: The integer array
     * @return: The length of LIS (longest increasing subsequence)
     */
    public int longestIncreasingSubsequence(int[] nums) {
        // write your code here
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int[] lis = new int[nums.length];
        int longest = 1;
        for (int i = 0; i < nums.length; i++) {
            lis[i] = 1; // nums[i] < nums[j]
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    if (lis[j] + 1 > lis[i]) {
                        lis[i] = lis[j] + 1;
                    }
                } else if (nums[i] == nums[j]) {
                    lis[i] = lis[j];
                }
            }
            if (lis[i] > longest) {
                longest = lis[i];
            }
        }
        return longest;
    }
}


```

<!--more-->


## First try: Err1

```java
public class Solution {
    /**
     * @param nums: The integer array
     * @return: The length of LIS (longest increasing subsequence)
     */
    public int longestIncreasingSubsequence(int[] nums) {
        // write your code here
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int[] lis = new int[nums.length];
        for (int i = 0; i < nums.length; i++) {
            lis[i] = 1; // nums[i] < nums[j]
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j] && lis[j] + 1 > lis[i]) {
                        lis[i] = lis[j] + 1;
                    }
                } else if (nums[i] == nums[j]) {
                    lis[i] = lis[j];
                } else {
                	lis[i] = 1; // nums[i] < nums[j]
                }
            }
        }
        //for (int i = 0; i < nums.length; i++) {
        //    System.out.println(lis[i]);
        //}
        return lis[nums.length - 1];
    }
}


```

## Err2

```java

public class Solution {
    /**
     * @param nums: The integer array
     * @return: The length of LIS (longest increasing subsequence)
     */
    public int longestIncreasingSubsequence(int[] nums) {
        // write your code here
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int[] lis = new int[nums.length];
        lis[0] = 1;
        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) { // <--
                    if (lis[j] + 1 > lis[i]) { // <--
                        lis[i] = lis[j] + 1; // <--
                    }
                } else if (nums[i] == nums[j]) {
                    lis[i] = lis[j];
                } else {
                		lis[i] = 1; // nums[i] < nums[j]
                }
            }
        }
        //for (int i = 0; i < nums.length; i++) {
        //    System.out.println(lis[i]);
        //}
        return lis[nums.length - 1];
    }
}


```

## Err3

```java

public class Solution {
    /**
     * @param nums: The integer array
     * @return: The length of LIS (longest increasing subsequence)
     */
    public int longestIncreasingSubsequence(int[] nums) {
        // write your code here
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int[] lis = new int[nums.length];
        // lis[0] = 1; <--
        for (int i = 0; i < nums.length; i++) {
        	  lis[i] = 1; // <--
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    if (lis[j] + 1 > lis[i]) {
                        lis[i] = lis[j] + 1;
                    }
                } else if (nums[i] == nums[j]) {
                    lis[i] = lis[j];
                } //else { <--
                //		lis[i] = 1; // nums[i] < nums[j] <--
                //} <--
            }
        }
        //for (int i = 0; i < nums.length; i++) {
        //    System.out.println(lis[i]);
        //}
        return lis[nums.length - 1];
    }
}


```

Error Msg: 

```java

[88,4,24,82,86,1,56,74,71,9,8,18,26,53,77,87,60]

Your input
[88,4,24,82,86,1,56,74,71,9,8,18,26,53,77,87,60]
Your output
6
Expected
7

```

![](http://7xihzu.com1.z0.glb.clouddn.com/20160823/lis.jpg)

Analysis: longest path not necessary through the **last index** of `lis[]` array.  

Solution: continous update the longest value and return global int`longest`.  

## Past solution: 

```java

public class Solution {
    /**
     * @param nums: The integer array
     * @return: The length of LIS (longest increasing subsequence)
     */
    public int longestIncreasingSubsequence(int[] nums) {
        // write your code here
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int[] lis = new int[nums.length];
        int longest = 1; // <--
        for (int i = 0; i < nums.length; i++) {
            lis[i] = 1; // nums[i] < nums[j]
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    if (lis[j] + 1 > lis[i]) {
                        lis[i] = lis[j] + 1;
                    }
                } else if (nums[i] == nums[j]) {
                    lis[i] = lis[j];
                }
            }
            if (lis[i] > longest) { // <--
                longest = lis[i]; // <--
            } // <--
        }
        return longest; // <--
    }
}


```

# Description: 
Given a sequence of integers, find the longest increasing subsequence (LIS).  

You code should return the length of the LIS.  

**Clarification**  

What's the definition of longest increasing subsequence?  

- The longest increasing subsequence problem is to find a subsequence of a given sequence in which the subsequence's elements are in sorted order, lowest to highest, and in which the subsequence is as long as possible. This subsequence is not necessarily contiguous, or unique.

- [Wikipedia LIS](https://en.wikipedia.org/wiki/Longest_increasing_subsequence)

**Example**  
For `[5, 4, 1, 2, 3]`, the LIS is `[1, 2, 3]`, return `3`  
For `[4, 2, 4, 5, 3, 7]`, the LIS is `[2, 4, 5, 7]`, return `4`  

# Thought Process:

## DP approach

`state: ` An array with length `nums.length`, which used to store number of LIS up to that index.  

For example:  
`nums` = `[9,3,6,2,7]`  
`lis` = `[1,1,2,1,3]`  

For `nums[2] = 6`, at index `2`, we have `lis[2] = 2`, which represents for `nums` up to index `2`, (`nums = [9,3,6]`). We have max LIS of `2`. DP stores value of previous index, and the future index base on the `lis` values computed before.  

For example: at index `2`, if `nums[2] = 6` is larger than `nums[0]`? No, we do nothing. Is `nums[2]` larger than `nums[1]`, if so, update `lis[2]` to `lis[1] + 1`, which we have `lis[2] = 2`. Since `nums[2]` is larger than `nums[1]`, which mean `3, 6` is the current longest increasing subsequence and therefore return the number of `2`. We follow the same process with until the last index of the array and return `longest`, the **largest** value record in `lis[]`.  
  

# Corner Case:
- `nums = [1]`  
- `nums = [1,1,1]`  
- largest LIS not necessary **through** the last index of the array `nums`.  


