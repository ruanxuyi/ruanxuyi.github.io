title: "Longest Common Substring"
date: 2016-10-10 01:15:21
tags:
- LintCode
- String
- DP
---

Try it here:   
[Longest Common Substring](http://www.lintcode.com/en/problem/longest-common-substring/)  

## <center>Description: </center>
Given two strings, find the longest common substring.  
Return the length of it.

**Notice**  
The characters in substring should occur continuously in original string. This is different with subsequence.

**Example**  
Given A = `"ABCD"`, B = `"CBCE"`, return `2`.

**Challenge** 
`O(n x m)` time and memory.

## <center>Thought Process:</center>

DP:  

### State
- `dp[i][j]` stores longest common substring from `A.substring(0,i)` and `B.substring(0,j)`.  

### Initialzation
- `dp[i][j] = 0` for first column & row.
  
### Function
```java
dp[i][j] = A.charAt(i - 1) == B.charAt(j - 1)? dp[i - 1][j - 1] + 1 : 0;
```
### Result

- `dp[i][j]` has non-zero value only when substring occur **continuously**.  
- `max` store global maximun of LCS.  
- `return max`  

<!--more-->

![](http://7xihzu.com1.z0.glb.clouddn.com/2016001010/dp2.jpg)

## <center>Code: </center>

Github: []()

```java
public class Solution {
    /**
     * @param A, B: Two string.
     * @return: the length of the longest common substring.
     */
    public int longestCommonSubstring(String A, String B) {
        // write your code here
        if(A.length() == 0 || B.length() == 0) {
            return 0;
        }
        int m = A.length();
        int n = B.length();
        // state
        int[][] dp = new int[m+1][n+1];
        // initialziation
        for (int i = 0; i < m + 1; i++) {
            dp[i][0] = 0;
        }
        for (int j = 0; j < n + 1; j++) {
            dp[0][j] = 0;
        }
        int max = 0;
        // function
        for (int i = 1; i < m + 1; i++) {
            for (int j = 1; j < n + 1; j++) {
                dp[i][j] = A.charAt(i-1) == B.charAt(j-1) ? dp[i-1][j-1] + 1 : 0;
                max = Math.max(dp[i][j], max);
            }
        }
        return max;
    }
}
```
<!--more-->


# Reference:
[Lintcode: Longest Common Substring 解题报告](http://www.cnblogs.com/yuzhangcmu/p/4199499.html)  

