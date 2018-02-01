title: "LintCode 119 - Edit Distance"
date: 2016-09-04 22:27:24
tags:
- LintCode
- LeetCode
- DP
- H
---

Lintcode: http://www.lintcode.com/en/problem/edit-distance/
Leetcode: https://leetcode.com/problems/edit-distance/description/

# Code: 

```java
public class Solution {
    /**
     * @param word1 & word2: Two string.
     * @return: The minimum number of steps.
     */
    public int minDistance(String word1, String word2) {
        // write your code here
        if (word1.compareTo(word2) == 0) {
            return 0;
        }
        // initialization
        int m = word2.length(); 
        int n = word1.length();
        int[][] minDis = new int[m+1][n+1];
        for (int i = 0; i < m + 1; i++) {
            minDis[i][0] = i;
        }
        for (int j = 0; j < n + 1; j++) {
            minDis[0][j] = j;
        }
        // fill up the rest of 2d minDis array
        for (int i = 1; i < m + 1; i++) {
            for (int j = 1; j < n + 1; j++) {
                if (word2.charAt(i - 1) == word1.charAt(j - 1)) {
                    minDis[i][j] = minDis[i-1][j-1];
                } else {
                    minDis[i][j] = 1 + findMin(minDis[i-1][j], minDis[i][j-1], minDis[i-1][j-1]);
                }
            }
        }
        return minDis[m][n];
    }
    private int findMin(int v1, int v2, int v3) {
        return Math.min(v1, Math.min(v2, v3));
    }
}

```

<!--more-->

# first draft

```java

public class Solution {
    /**
     * @param word1 & word2: Two string.
     * @return: The minimum number of steps.
     */
    public int minDistance(String word1, String word2) {
        // write your code here
        if (word1.length() == 0 || word2.length() == 0 || 
        word1.compareTo(word2) == 0) {
            return 0;
        }
        // initialization
        int[][] minDis = new int[word1.length()][word2.length()];
        if (word1.charAt(0) == word2.charAt(0)) {
            minDis[0][0] = 0;
        } else {
            minDis[0][0] = 1;
        }
        for (int i = 1; i < word1.length(); i++) {
            minDis[0][i] = word2.charAt(0) == 
                word1.charAt(i) ? minDis[0][i-1] : minDis[0][i-1]++;
        }
        for (int j = 1; j < word2.length(); j++) {
            minDis[j][0] = word1.charAt(0) == 
                word2.charAt(j) ? minDis[j-1][0] : minDis[j-1][0]++;
        }
        // fill up the rest of 2d minDis array
        for (int i = 1; i < word1.length(); i++) {
            for (int j = 1; j < word2.length(); j++) {
                if (i == j && word1.charAt(i) == word2.charAt(j)) {
                    minDis[i][j] = minDis[i-1][j-1];
                } else {
                    minDis[i][j] = findMin(minDis[i-1][j], minDis[i][j-1], minDis[i-1][j-1])+1;
                }
            }
        }
        return minDis[word1.length() - 1][word2.length() - 1];
    }
    private int findMin(int v1, int v2, int v3) {
        return Math.min(v1, Math.min(v2, v3));
    }
}

```

# second draft

```java

public class Solution {
    /**
     * @param word1 & word2: Two string.
     * @return: The minimum number of steps.
     */
    public int minDistance(String word1, String word2) {
        // write your code here
        if (word1.compareTo(word2) == 0) {
            return 0;
        }
        // initialization
        int m = word2.length(); // 1
        int n = word1.length(); // 2
        int[][] minDis = new int[m+1][n+1]; // 2 x 3
        // System.out.println("size: " + minDis.length + " x" + minDis[0].length);
        for (int i = 0; i < m + 1; i++) {
            minDis[i][0] = i;
        }
        for (int j = 0; j < n + 1; j++) {
            minDis[0][j] = j;
        }
        // fill up the rest of 2d minDis array
        for (int i = 1; i < n + 1; i++) {
            for (int j = 1; j < m + 1; j++) {
                if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                    minDis[i][j] = minDis[i-1][j-1];
                } else {
                    //System.out.println("i, j: " + i + "," + j);
                    minDis[i][j] = 1 + findMin(minDis[i-1][j], minDis[i][j-1], minDis[i-1][j-1]);
                }
            }
        }
        return minDis[m][n];
    }
    private int findMin(int v1, int v2, int v3) {
        return Math.min(v1, Math.min(v2, v3));
    }
}

```

# Description: 

Given two words word1 and word2, find the minimum number of steps required to convert word1 to word2. (each operation is counted as 1 step.)

You have the following 3 operations permitted on a word:

- Insert a character
- Delete a character
- Replace a character

**Example:**  
Given `word1` = `"mart"` and `word2` = `"karma"`, return `3`.

# Thought Process:

1. find **minimum** step number -> DP approach  
2. 2 strings -> construct 2D matrix `int[][] dp` 
3. observation: if `w1.charAt(i) == w2.charAt(j)`, we have `dp[i][j] = dp[i-1][j-1]` since no edit is needed  
4. otherwise, we can perform either of the three ops and take one with min edit distance.  





It is overall a very comprehensive problem and it tests not only skill in using DP for the particualr problem, it also tests knowledge in manpulation of `String` type in Java programming. Familair with `compareTo()`, `equals()` and `charAt()` methods from `String` types as well as `==` operators comparison on primitive types are essential for this problem.  

The basic idea of this probelm is utilizing 2D array to stores minimum steps of changes from `word1[0:i]` to `word2[0:j]`. As you trace through the whole process, you will see the relationship of current minStep value to its neighbors.  

![](http://7xihzu.com1.z0.glb.clouddn.com/edit-distance.jpg)

From example above, `word1` = "mart", `int n = word1.length()`, and `word2` = "karma", where `int m = word2.length()`. The reason we initialize a 2d array of size of `m + 1 x n + 1`instead of `m x n ` is to generalize the algorithm to work even when either `word1 = ""` or `word2 = ""` OR both of them are `""`.  

For example, `minDis[2][1] = 2`, which represents the min steps of changes from `"ka"` to `"m"` is 2.  
 
- replace `k` with `m`  
- insert `a`).  

`minDis[2][2] = 1` represents the min steps of changes from `"ka"` to `"mar"` is 1, which is true:  

- replace `k` with `m`  

After we complete the whole 2d array, we found following relations:  

## Algorithm
If `word1[i-1] == word2[j-1]`, two chars are identical, no edit was needed `minDis[i][j] = minDis[i-1][j-1]`.  

If `word1[i-1] != word2[j-1]`, We have following three cases:

Say we are looking for value for `minDis[2][3]` min steps from `"ka"` to `"mar"`. We have following three ways to get there:  

- From `minDis[2][2]`: `"ma"` -> **add** `r` to word2 -> steps: `minDis[2][2]` + 1 = 2  
- From `minDis[1][3]`: `"mar"` -> it took 3 steps from `k` to `"mar"`. and we need **delete** `"a"` from `word2` to get same word distance from From `minDis[1][3]` -> steps: `minDis[1][3]` + 1 = 4    
- From `minDis[1][2]`: **replace** `"a"` with `"r"` or vise versa -> steps: `minDis[1][2]` + 1 = 3  

Since we are taking the minSteps, we choose the **minimum of three** values above.  

# Corner Case:
- `minDis[0][i]`:  `word2` empty, min steps take to get to `word1[0:i-1]`  
- `minDis[i][0]`:  `word1` empty, min steps take to get to `word2[i-1:0]`

# Errors

## Error 1
- compare `char` use `==`

line 31 of first draft: `if (i == j && word1.charAt(i) == word2.charAt(j)) {`
Since `char` is one of the premative type, we can simply use `==` to compare the values, dont use `compareTo` or `equals`.   

> Note:  
> There are eight primitive types in Java: `boolean`、`byte`、`char`、`short`、`int`、`float`、`double`、 and `long`.  

## Error 2
- `null` word

```
Input
"b", ""
Output
0
Expected
1
```
In line 9-10 of the first draft: 

```java
        if (word1.length() == 0 || word2.length() == 0 || 
        word1.compareTo(word2) == 0) {
            return 0;
        }

```
If only one of the array is `null`, return the size of the other word.


```java
        if (word1.compareTo(word2) == 0) {
            return 0;
        }
        if (word1.equals("")) return word2.length();
        if (word2.equals("")) return word1.length();

```

## Error 3: 
- misplaced dimension parameters for `minDis[][]`

```

Input
"ab", "a"
Expected
1
Error Message
Exception in thread "main" java.lang.ArrayIndexOutOfBoundsException: 1 at Solution.minDistance(Solution.java:21) at Main.main(Main.java:10)

```

`int[][] minDis = new int[word1.length()][word2.length()];` dimension of 2d array was wrong. should be `int[][] minDis = new int[word2.length()][word1.length()];`

## Error 4: 
- flaws in algorithm

first draft did not passed following two cases: 
- `word1 = pneumonoultramicroscopicsilicovolcanoconiosis` and `word2 = ultramicroscopically` case.  
- `word1 = aaaaaaaaaaaaaaaaaaabbbbbbbbbdfadsfjalsdjfalsdjfsadfadf` and `word2 = aaaaaabbbbbbbbbdfjaldjf`

After reading the solution, I realized that the solution is better than my approch (first draft) in following two ways: 

1.The solution use `minDis[m+1][n+1]` instead of `minDis[m][n]`, this provide better explaintion for initialization values for `minDis[0][]` and `minDis[][0]`.  
2.The solution also assign minDis values on row `minDis[0][i]`, as well as on column `minDis[j][0]`for situation when either `word1 = ""` or `word2 = ""`.  
 

## Error 5: 
- dimension mismatch in `minDis`.
- line 24-33 of second draft.

During initialization steps, `minDis` in dimension `m x n` 
```java
        int[][] minDis = new int[m+1][n+1]; // 2 x 3
```

However, in the update steps: 

```java

        for (int i = 1; i < n + 1; i++) {
            for (int j = 1; j < m + 1; j++) {
                if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                    minDis[i][j] = minDis[i-1][j-1];
                } else {
                    //System.out.println("i, j: " + i + "," + j);
                    minDis[i][j] = 1 + findMin(minDis[i-1][j], minDis[i][j-1], minDis[i-1][j-1]);
                }
            }
        }

```

line 5, line 8, `minDis` misused `minDis` in dimension `minDis[i][j]` where `i = n` and `j = m`.  

**Quick fix:** change `i` to loop through `m` and `j` to loop through `n` to match dimension of `minDis`, `m x n`. Since order of `i` and `j` switched, `word1` and `word2` on line 5 has to be switched as well.  

```java

        for (int i = 1; i < m + 1; i++) {
            for (int j = 1; j < n + 1; j++) {
                if (word2.charAt(i - 1) == word1.charAt(j - 1)) {
                    minDis[i][j] = minDis[i-1][j-1];
                } else {
                    //System.out.println("i, j: " + i + "," + j);
                    minDis[i][j] = 1 + findMin(minDis[i-1][j], minDis[i][j-1], minDis[i-1][j-1]);
                }
            }
        }

```


# Reference: 

[Eight primitive types in Java](http://www.cnblogs.com/ycpanda/p/3637153.html)   
[Google 大牛 Edit Distance -- LeetCode](http://blog.csdn.net/linhuanmars/article/details/24213795)   

