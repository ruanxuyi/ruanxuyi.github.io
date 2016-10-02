title: "LintCode 118 - Distinct Subsequences"
date: 2016-09-13 14:43:06
tags:
- LintCode
- H
- DP
---

[Distinct Subsequences](http://www.lintcode.com/en/problem/distinct-subsequences/)

# Code: 
# 2D array version ($O(mn)$ space complexity)

```java
public class Solution {
    /**
     * @param S, T: Two string.
     * @return: Count the number of distinct subsequences
     */
    public int numDistinct(String S, String T) {
        // write your code here
        // coner case
        if (T.length() == 0) { 
            return 1;
        }
        if (S.length() == 0) {
            return 0;
        }
        int m = S.length();
        int n = T.length();
        int[][] dp = new int[m + 1][n + 1];
        // row initialization
        for (int j = 0; j < dp[0].length; j++) {
            dp[0][j] = 0;
        }
        // column initialization
        for (int i = 0; i < dp.length; i++) {
            dp[i][0] = 1;
        }
        for (int j = 1; j < dp[0].length; j++) {
            for (int i = 1; i < dp.length; i++) {
                dp[i][j] = dp[i-1][j];
                if (S.charAt(i - 1) == T.charAt(j - 1)) {
                    dp[i][j] += dp[i-1][j-1];
                }
            }
        }
        return dp[m][n];
    }
}
```

<!--more-->

## 1D Solution: 

[[Leetcode] Distinct Subsequences 解题报告](http://fisherlei.blogspot.com/2012/12/leetcode-distinct-subsequences_19.html)


# Description: 
Given a string `S` and a string `T`, count the number of distinct subsequences of T in S.

A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ACE" is a subsequence of "ABCDE" while "AEC" is not).

Example
Given `S = "rabbbit"`, `T = "rabbit"`, return `3`.

# Thought Process:

![](http://7xihzu.com1.z0.glb.clouddn.com/distint-sequence.jpg)

## State

Since we are xxxx, we are using 2D-array `dp[m + 1][n + 1]`as the state. Where `m = S.length()` and `n = T.length()`.   

## Initalization

Since it is not coordinatation problem, we have extra column and row append to the left and top edge of the 2-d array.  

On first column, every possible `S` has `1` subsequence that is identical to `null`. Therefore we have: 

```java
		  // column initialization
        for (int i = 0; i < dp.length; i++) {
            dp[i][0] = 1;
        }
```

For the first row, if `S = ""`, There is no possible subsequence exist except the first locaiton. Therefore, we have the following:  

```java
        // row initialization
        for (int j = 0; j < dp[0].length; j++) {
            dp[0][j] = 0;
        }
```

## Funciton

As we went through the table, we are able to detect the following relations.  
For current position `dp[i][j]`  
1.`dp[i][j]` = `dp[i-1][j]`
2.`if (S.charAt(i-1) == T.charAt(j-1)) dp[i][j] =  dp[i][j] + dp[i-1][j-1]`  

For the first condition, add 1 char to `S` (`dp[i][j]`)should result **at least** the same number of subsequece in (`dp[i-1][j]`). It could have more subsequences, which was handle in the second condition.

**For example:**  
if `S = rab`, and `T = rab` has value 1 in `dp` mapping. If we add `t` on both side (`S = rabt` and `T = rabt`), we are likely to have same value of `1`. 

Therefore,  
if `S.charAt(i - 1) == T.charAt(j - 1)`, we have `dp[i][j] += dp[i-1][j-1]`. 



## Solution


# Corner Case:
- `S = ""`  
- `T = ""`   
