title: "LintCode 76 - Longest Increasing Subsequence"
date: 2016-08-21 11:49:07
tags:
- LintCode
- DP
- H
- BinarySearch
---

http://www.lintcode.com/en/problem/longest-increasing-subsequence/#
https://leetcode.com/problems/longest-increasing-subsequence/description/

# Code: 

## Brute Force
- find ALL possible subsequence of given array $2^n$  
- each subsequence, we need `O(n)` to find LIS  
- time complexity: $O(n * 2^n)$  
- space complexity: $O(n)$  

## Recursive DP
https://www.geeksforgeeks.org/?p=12832


## Iterative DP
- time complexity: $O(n^2)$  
- space complexity: $O(n)$  

### Algorithm
- to find `lis[n]`  
- go through all element before `n`, find the one with **max** `lis` value, which value of element is also **smaller** than `nums[n]` and store `max value + 1` into `lis[n]`  


```java

class Solution {
    public int lengthOfLIS(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        int len = nums.length;
        int[] lis = new int[len];
        Arrays.fill(lis, 1);
        int largest = lis[0];
        
        for (int i = 1; i < len; i++) {
            for (int j = i - 1; j >= 0; j--) {
                if (nums[i] > nums[j]) {
                    lis[i] = Math.max(lis[i], lis[j] + 1);
                }
            }
            largest = Math.max(largest, lis[i]);
        }
        
        return largest;
    }
}

```

## Iterative DP + Binary Search Approach
time complexity: $O(nlogn)$  

https://www.geeksforgeeks.org/longest-monotonically-increasing-subsequence-size-n-log-n/

<!--more-->

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


## Soluton2 (returns acutal LIS)
```java

public class LIS {
	public static void main (String[] args) {
		int[] nums = {15, 27, 14, 38, 26, 55, 46, 65, 85};
		String lis = findLIS(nums);
		System.out.println("longest increasing subsequence: " + lis);
	}
	private static String findLIS(int[] nums) {
		String[] lis = new String[nums.length];
		// initalization
		lis[0] = Integer.toString(nums[0]);
		// subproblem
		for (int i = 1; i < nums.length; i++) {
			lis[i] = "";
			for (int j = 0; j < i; j++) {
				if (nums[j] < nums[i] && lis[i].length() < lis[j].length() + 1) {
					lis[i] = lis[j];
				}
			}
			lis[i] = lis[i] + Integer.toString(nums[i]);
		}
		for (int i = 0; i < lis.length; i++) {
			System.out.println("lis[" + i + "] = " + lis[i]);
		} 
		return lis[nums.length-1];
	}
}


```

# application 
- stock price: only want to see progression of non-decreasing price points  



# Reference:
[Youtube video of a lecture from MIT's Open-Coursware](https://www.hackerrank.com/challenges/longest-increasing-subsequent)  


# Logs
- 08-21-2016: initial post  
- 10-30-2016: update with solution returns actual LIS.  
- 01-19-2018: clean up and update iterative DP  

