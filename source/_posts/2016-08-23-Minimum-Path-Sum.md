title: "LintCode 110 - Minimum Path Sum"
date: 2016-08-23 02:04:18
tags:
- LintCode
- DP
---

[Minimum Path Sum](http://www.lintcode.com/en/problem/minimum-path-sum/)

# Code: 

## DP approach

```java

public class Solution {
    /**
     * @param grid: a list of lists of integers.
     * @return: An integer, minimizes the sum of all numbers along its path
     */
    public int minPathSum(int[][] grid) {
        // write your code here
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return -1;
        }
        int M = grid.length;
        int N = grid[0].length;
        int[][] state = new int[M][N];
        state[0][0] = grid[0][0];
        for (int i = 1; i < N; i++) {
            state[0][i] = state[0][i-1] + grid[0][i];
        }
        for (int j = 1; j < M; j++) {
            state[j][0] = state[j-1][0] + grid[j][0];
        }
        for (int i = 1; i < M; i++) {
            for (int j = 1; j < N; j++) {
                state[i][j] = grid[i][j] + Math.min(state[i-1][j], state[i][j-1]);
            }
        }
        return state[M - 1][N - 1];
    }
}


```

<!--more-->

# Description: 

Given a **m x n** grid filled with non-negative numbers, find a path from top left to bottom right which **minimizes** the sum of all numbers along its path.

 **Notice**  

You can only move either down or right at any point in time.  

# Thought Process:

**initialization**: 

```java
		int M = grid.length;
        int N = grid[0].length;
        int[][] state = new int[M][N];
        state[0][0] = grid[0][0];
        for (int i = 1; i < N; i++) {
            state[0][i] = state[0][i-1] + grid[0][i];
        }
        for (int j = 1; j < M; j++) {
            state[j][0] = state[j-1][0] + grid[j][0];
        }
```

**state**: 2d `state` array stores current min path sum up to that location.  
**function**: ` state[i][j] = grid[i][j] + Math.min(state[i-1][j], state[i][j-1]);`  
**solution**: `return state[M - 1][N - 1];`  


# Corner Case:

