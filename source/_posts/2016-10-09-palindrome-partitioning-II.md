title: "palindrome partitioning II"
date: 2016-10-09 20:41:58
tags:
- LintCode
- DP
- Palindrome
---
Try it here: 
[Palindrome Partitioning II](http://www.lintcode.com/en/problem/palindrome-partitioning-ii/)

## <center>Description:</center>
Given a string s, cut s into some substrings such that every substring is a palindrome.  
Return the **minimum** cuts needed for a palindrome partitioning of s.  

**Example**
Given `s = "aab"`,

Return `1` since the palindrome partitioning `["aa", "b"]` could be produced using `1` cut.

## <center>Thought Process:</center>

### State
1.`pal[s.length() + 1]`

`pal[i]` stores minimum cuts for string `s[0, i-1]` that every substrings is an palindrome.  

2.`dp[s.length()][s.length()]`  

`dp[j][i-1]` stores if `s[j, i-1]` a palindrome. trade **space** for **time** (dp).  

### Initialization

1.`pal[0] = -1` // set as -1 so that `pal[1] = 0`.  
2.`pal[i] = Integer.MAX_VALUE`. // more than one way to partition a string, desire the **minimum** cuts.  
	
3.`dp[j][i-1] = false`  

<!--more-->

### Function
1.determine if string `s[j, i-1]` is a palindrome.  

`s[j, i - 1]` is a palindrome when `charAt[j] == charAt[i-1] && ((i - 1 - j) || (dp[j+1][i-2]))`

2.if(palindrome) -> `pal[i] = Math.min (pal[j] + 1, pal[i])`

	ex. abbab -> 
	1.a|b|bab   -> 2 cuts
	2.abba|b    -> 1 cut

more than one way to partition a string, desire the **minimum** cuts. 

### Result
1.`return pal[len]`


## <center>Code:</center>
### V2 (addtion dp for palindrome)
```java
public class Solution {
    /**
     * @param s a string
     * @return an integer
     */
    public int minCut(String s) {
        // write your code here
        if (s.length() == 0 || s == null) {
            return 0;
        }
        int len = s.length();
		 // state
        int[] pal = new int[len + 1];
        boolean[][] dp = new boolean[len][len]; // store history of palindrome
        // initaliziation
        pal[0] = -1;
        for (int i = 1; i < s.length() + 1; i++) {
            pal[i] = Integer.MAX_VALUE;
            //pal[i] = 0;
            for (int j = 0; j < i; j++) {
                dp[j][i-1] = false;
                // function
                if (s.charAt(j) == s.charAt(i-1) && ((i - 1 - j <= 2) || dp[j+1][i-2] == true)) {
                    dp[j][i-1] = true;
                    pal[i] = Math.min(pal[i], pal[j] + 1);
                }
            }
        }
        // result
        return pal[len];
    }
};
```

### v1 (time out) 
1.failed to consider time complexity of `StringBuilder(s).reverse()`

```java
import java.lang.StringBuilder;

public class Solution {
    /**
     * @param s a string
     * @return an integer
     */
    public int minCut(String s) {
        // write your code here
        if (s.length() == 0) {
            return 0;
        }
        // boolean[] pal = new boolean[](s.length + 1);
        int[] pal = new int[s.length() + 1];
        // initaliziation
        pal[0] = -1;
        for (int i = 1; i < s.length() + 1; i++) {
            // pal[i] = Math.MAX_VALUE;
            pal[i] = Integer.MAX_VALUE;
            for (int j = 0; j < i; j++) {
                if (isPalindrome(s.substring(j, i))) {
                    pal[i] = Math.min(pal[i], pal[j] + 1);
                }
            }
        }
        return pal[s.length()];
    }
    private boolean isPalindrome(String s) {
        // determine if it is palindrome
        String reverse = new StringBuilder(s).reverse().toString();
        return reverse.equals(s);// learn more about this
    }
};
```



## Reference: 

[LeetCode: Palindrome Partitioning II 解题报告](http://www.cnblogs.com/yuzhangcmu/p/4148892.html)  
	