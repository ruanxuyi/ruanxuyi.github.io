title: "Longest Common Subsequence"
date: 2016-10-10 07:51:50
tags:
- LintCode
- DP
- LCS
---

Try it here:  
[Longest Common Subsequence](http://www.lintcode.com/en/problem/longest-common-subsequence/)

## <center> Description: </center>

Given two strings, find the **[longest common subsequence(LCS)](https://en.wikipedia.org/wiki/Longest_common_subsequence_problem)**.  
Your code should return the length of LCS.



**Example**
For `"ABCD"` and `"EDCA"`, the LCS is `"A" (or "D", "C"),` return `1`.

For `"ABCD"` and `"EACB"`, the LCS is `"AC"`, return `2`.

## <center> Process: </center>

### State
1.`lcs[m + 1][n + 1]`  
2.`lcs[i][j]` stores current number of LCS for `s1[0,i-1]` and `s2[0, j-1]`


### Initialization
1.initialize zero-value for first col/row.  

### Function

`lcs[i][j] = A.charAt(i-1) == B.charAt(j-1) ? lcs[i-1][j-1] + 1 : Math.max(lcs[i-1][j], lcs[i][j-1]);`

1.from `s1[0,i-1]` `s2[0,j-1]` to `s1[0,i]` `s2[0,j]`  
if `charAt(i)` is identical to `charAt(j)`, `lcs[i][j] = lcs[i-1][j-1] + 1` 

2.otherwise, **adding** extra irrelevant chars will not affect # of LCS.  

### Result

1.return `lcs[m][n]`

## <center> Code: </center>

```java
public class Solution {
    /**
     * @param A, B: Two strings.
     * @return: The length of longest common subsequence of A and B.
     */
    public int longestCommonSubsequence(String A, String B) {
        // write your code here
        if (A.length() == 0 || B.length() == 0) {
            return 0;
        }
        int m = A.length();
        int n = B.length();
        // state
        int[][] lcs = new int[m + 1][n + 1];
        
        for (int i = 0; i < m + 1; i++) {
            for (int j = 0; j < n + 1; j++) {
                if (i == 0 || j == 0) {
                    // initialization
                    lcs[i][j] = 0;
                } else {
                    // fucntion
                    lcs[i][j] = A.charAt(i-1) == B.charAt(j-1) ? lcs[i-1][j-1] + 1 : Math.max(lcs[i-1][j], lcs[i][j-1]);
                }
            }
        }
        // result
        return lcs[m][n];
    }
}
```

<!--more-->

[github]()

## <center> Reference: </center>
[Lintcode:Longest Common Subsequence 解题报告](http://www.cnblogs.com/yuzhangcmu/p/4199531.html)  
