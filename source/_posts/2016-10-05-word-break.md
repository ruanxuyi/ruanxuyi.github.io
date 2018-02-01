title: "LintCode 107 - Word Break"
date: 2016-10-05 14:39:46
tags:
- LintCode
- DP
- String
- H
---

http://www.lintcode.com/en/problem/word-break/


# <center> Code: </center>

```java
public class Solution {
    /**
     * @param s: A string s
     * @param dict: A dictionary of words dict
     */
    private int getMaxWordLength(Set<String> dict) {
        int maxLength = 0;
        for (String word : dict) {
            maxLength = Math.max(maxLength, word.length());
        }
        return maxLength;
    }
    
    public boolean wordBreak(String s, Set<String> dict) {
        // write your code here
        if (s == null || s.length() == 0 || dict == null) {
            return true;
        }
        int maxLen = getMaxWordLength(dict);
        boolean[] locs = new boolean[s.length() + 1];
        // initializaiton
        locs[0] = true;
        // function
        for (int i = 1; i <= s.length(); i++) {
            locs[i] = false;
            for (int j = i - 1; j >=0; j--) {
                if ((i - j) > maxLen) {
                    continue;
                }
                if (locs[j] && dict.contains(s.substring(j, i))) {
                    locs[i] = true;
                    break;
                }
            }
        }
        return locs[s.length()];
    }
}
```


<!--more-->

# <center>Description:</center> 

Given a string s and a dictionary of words dict, determine if s can be break into a space-separated sequence of one or more dictionary words.

Example
Given `s = "lintcode"`, `dict = ["lint", "code"]`.

Return true because `"lintcode"` can be break as `"lint code"`.

# <center>Thought Process:</center>

- imagine cutting a word into **two pieces** with a knife  
- if the **left** half is cuttable (`locs[j] == true`), and the **right** half exists in dictionary.  
- we said the substring is cuttable -> return `true`  

## State  
- construct a `boolean` array `locs` of size `s.length() + 1`  

```java
	boolean[] locs = new boolean[s.length() + 1];  
```

## Function  

![](http://7xihzu.com1.z0.glb.clouddn.com/2016001005/wb.jpg)

```java
	locs[i] = locs[j] && dict.contains(s.substring(j, i));
```

- imgine we cut the word at `j`
- if `locs[j] == true`( `s.substring(0,j)` has proven to be cuttable.)  
- && dictionary contains `s.substring(j, i)`.
- we can then say `s.substring(0, i)` is cuttale.  


## Initialization
- `locs[0] = true`  
- if the **first** char of the word `s.substring(0,1)` exists in dictionary.  
- locs[0] has to be forced to `true`. 

## Result: 
- `return locs[s.length()];`

# <center>Corner Case:</center>
- `j < i` ->  if we use `j <= i ` -> when j == i, `s.substring(j, i)` will be not meaningful.

# <center>Reference:</center>

[WordBreak.java](https://github.com/yuzhangcmu/LeetCode/blob/master/dp/WordBreak.java)  
[【Leetcode-Medium】Word Break 解题报告](http://blog.sina.com.cn/s/blog_eb52001d0102v2hp.html)  
[ Word break优化解法](http://www.jiuzhang.com/qa/1745/)  
