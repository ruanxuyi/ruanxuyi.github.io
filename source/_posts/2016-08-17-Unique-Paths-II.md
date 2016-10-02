title: "LintCode 115 - Unique Paths II"
date: 2016-08-17 10:37:33
tags:
- LintCode
- DP
---

[Unique Paths II](http://www.lintcode.com/en/problem/unique-paths-ii/)

# Code: 

```java

public class Solution {
    /**
     * @param obstacleGrid: A list of lists of integers
     * @return: An integer
     */
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        // write your code here
        // dont forget check null array!
        if (obstacleGrid == null || obstacleGrid.length == 0 || obstacleGrid[0].length == 0) {
            return 0;
        }
        int rowSize = obstacleGrid.length;
        int colSize = obstacleGrid[0].length;
        int[][] matrix = new int[rowSize][colSize];
        
        for (int i = 0; i < colSize; i++) {
            if (obstacleGrid[0][i] != 1) {
                matrix[0][i] = 1;
            } else {
                break;
            }
        }
        for (int j = 0; j < rowSize; j++) {
            if (obstacleGrid[j][0] != 1) {
                matrix[j][0] = 1;
            } else {
                break;
            }
        }
        for (int i = 1; i < rowSize; i++) {
            for (int j = 1; j < colSize; j++) {
                if (obstacleGrid[i][j] != 1) {
                    matrix[i][j] = matrix[i][j-1] + matrix[i-1][j];
                } else {
                    matrix[i][j] = 0;
                }
            }
        }
        return matrix[rowSize - 1][colSize - 1];
    }
}

```

<!--more-->



# Description: 

Follow up for "Unique Paths":

Now consider if some obstacles are added to the grids. How many unique paths would there be?

An obstacle and empty space is marked as `1` and `0` respectively in the grid.
 
**Example**  
For example,
There is one obstacle in the middle of a 3x3 grid as illustrated below.

```
[
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
```

The total number of unique paths is `2`.

# Thought Process:

```java
0 0
0 0
0 0
1 0
0 0
```
Since `(3,0)` is a `1` which represent an obstacle, during the initialization process, we need to set not only `(3,0)'s ` value to `0`, but also need to set `(4,0)'s` value to zero, since `(3,0)` is the only way to get to `(4,0)`.

We can implement this by initializing the first column and row's value to `1`, we simply break once we detect the first values `1` from `obstacleMatrix`.  


# Corner Case:
- first try only consider `1` - obstacle in the middle of the matrix. Need to consider the case where obstcles are on the side of matrix.  
- forgot. also need to consider `null` array and `size = 0` array.  

# Reference: 

[Unique Paths II 参考程序](http://www.jiuzhang.com/solutions/unique-paths-ii/)


