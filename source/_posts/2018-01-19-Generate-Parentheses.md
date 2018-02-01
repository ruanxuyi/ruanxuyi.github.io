title: "LeetCode22 - Generate Parentheses"
date: 2018-01-19 13:19:12
tags:
- LeetCode
- LintCode
- Parentheses Related
---


## <center> description </center>

https://leetcode.com/problems/generate-parentheses/description/

Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

For example, given `n = 3`, a solution set is:

```
[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]
```


## <center> code </center>

```java
class Solution {
	public static List<String> generateParenthesis(int n) {
        List<String> result = new ArrayList<String>();
        helper(n-1, n, "(", result);
        return result;
    }
    
    public static void helper(int left, int right, String temp, List<String> result) {
        if (left == 0 && right == 0) {
            result.add(temp);
            return;
        }
        
        if (left > right || left < 0 || right < 0) {
            return;
        }
        
        // function
        helper(left-1,right,temp+"(",result);
        helper(left,right-1,temp+")",result);        
    }
}
```

<!--more-->

## <center> algorithm </center>

example: `n = 3` means we have 3 `'('` and 3 `')'`, how to combine all 6 of them to make a valid combination of parentheses  

at each step, we have following **two choices**:  
1. add a `'('` if we still have left parentheses  
2. add a `')'` if we still have right parentheses AND there exist matching left parentheses  

when we use up all left and right aprentheses, we can add it to result  

Note, we need to put `'('` at the first step since it is invalid to start with `')'`  

The recursive tree looks like this:  





## <center> complexity analysis </center>

**time**: $O(c)$ where `c` is the number of total strings in which parens are matched.  `c` is known as Catalan number, whose complexity order is $O(3^n)$  

**space**: $O(n)$

## <center> summary </center>
括号相关的题目  
- # of 左括弧 > 右括弧  

## <center> application </center>

## <center> reference </center>
