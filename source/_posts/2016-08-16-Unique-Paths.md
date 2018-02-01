title: "LintCode 114 - Unique Paths"
date: 2016-08-16 14:50:53
tags:
- LintCode
- DP
- H
---


http://www.lintcode.com/en/problem/unique-paths/  
https://leetcode.com/problems/unique-paths/description/


# Code: 
## Recursive DP (time out)

```java
public class Solution {
    /**
     * @param n, m: positive integer (1 <= n ,m <= 100)
     * @return an integer
     */
    public int uniquePaths(int m, int n) {
        // write your code here
        return findPath(1,1,m,n);
    }
    
    public static int findPath(int row, int col, int rowBound, int colBound) {
        if (row > rowBound || col > colBound) {
            return 0;
        }
        if (row == rowBound && col == colBound) {
            return 1;
        }
        return findPath(row, col+1, rowBound, colBound) + findPath(row+1, col, rowBound, colBound);
    }
}

```

## Recursive DP + memorizations

```java
public class Solution {
    /**
     * @param n, m: positive integer (1 <= n ,m <= 100)
     * @return an integer
     */
    public int uniquePaths(int m, int n) {
        // write your code here
        int[][] paths = new int[m+1][n+1];
        return findPath(1,1,m,n, paths);
    }
    
    public static int findPath(int row, int col, int rowBound, int colBound, int[][] paths) {
        if (row > rowBound || col > colBound) {
            return 0;
        }
        if (row == rowBound && col == colBound) {
            return 1;
        }
        if (paths[row][col] == 0) {
            paths[row][col] = findPath(row, col+1, rowBound, colBound, paths) + findPath(row+1, col, rowBound, colBound, paths);
        }
        return paths[row][col];
    }
}

```

## Iterative DP

```java
public class Solution {
    /**
     * @param n, m: positive integer (1 <= n ,m <= 100)
     * @return an integer
     */
    public int uniquePaths(int m, int n) {
        // write your code here
        if (m == 0 || n == 0) {
            return 0;
        }
        int[][] matrix = new int[m][n];
        // only one path from start to any location at column 1/row 1
        for (int i = 0; i < m; i++) {
            matrix[i][0] = 1;
        }
        for (int j = 0; j < n; j++) {
            matrix[0][j] = 1;
        }
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                matrix[i][j] = matrix[i][j-1] + matrix[i-1][j];
            }
        }
        return matrix[m-1][n-1];
    }
}

```

<!--more-->



# Description: 

A robot is located at the top-left corner of a `m x n` grid (marked 'Start' in the diagram below).

The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

How many possible unique paths are there?

**Example**:

![](http://7xihzu.com1.z0.glb.clouddn.com/20160816/unique-path.png)

Above is a 3 x 7 grid. How many possible unique paths are there?


# Thought Process:

Without thinking about using dynamic programming, I first came up with a hardcode version that was not working fullly. Later, I tried further with DP approch and came up with second version.  

In order to find the **number of unique paths** to from start point `(0, 0)` to end point `(m, n)`, we can **first** find out how many paths from `(1, 1)` to `(m, n-1)` and `(m-1, n)` [`(m, n)`'s adjacent points]. If we take the sum of number of unique paths from `(1,1)` to two points above, the result will be number of unique paths from `(1,1)` to `(m,n)`.  

To implement this algorithm, we first need to initialize all locations at first row/coloumn to `1's`. With base case setting up, we can go through all the elements in the matrix and fill the current location with the sum of locations from **left and above**, until all the matrix locations were filled.  

The idea of DP comes from we pre-calulate the number of unique paths from `(1,1)` to `(m, n-1)` and `(m-1, n)`. Now, instead of going through all the sumuation from begining, we only need to compute the sum of value of those two locations to get the result for `(m, n)`.  


# Corner Case:
- first row and column all initialized to `1` since there is only one path from `(1, 1)` to any point on first column/row.  
- `m = 0, n = 0`, return `0`.  



## Version0 Hard Code (Not passed)

```java
public class Solution {
    /**
     * @param n, m: positive integer (1 <= n ,m <= 100)
     * @return an integer
     */
    public int uniquePaths(int m, int n) {
        // write your code here
        if (m == 1 || n == 1) {
            return 1;
        }
        int startR_x = 1, startR_y = 2;
        int startD_x = 2, startD_y = 1;
        int endL_x = m, endL_y = n - 1;
        int endT_x = m - 1, endT_y = n;
        int totalPath = 0;
        totalPath += (endT_y - startR_y + 1) * (endT_x - startR_x);
        totalPath += (endL_y - startR_y + 1) * (endL_x - startR_x);
        //System.out.println(totalPath);
        if (startD_x < endT_x) {
            totalPath += (endT_y - startD_y + 1) * (endT_x - startD_x);
        }
        //System.out.println(totalPath);
        totalPath += (endL_y - startD_y + 1) * (endL_x - startD_x);
        //System.out.println(totalPath);
        if (startR_x == endL_x) {
            totalPath +=1;
        }
        if (startR_x == endT_x) {
            totalPath +=1;
        }
        if (startD_x == endL_x) {
            totalPath +=1;
        }
        if (startD_x == endT_x) {
            totalPath +=1;
        }
        return totalPath;
    }
}

```


# Reference: 

[Unique Paths Solution by JiuZhang](http://www.jiuzhang.com/solutions/unique-paths/)

# logs
## 01/28/2018 update:   
- add Recursive DP, and Recursive DP + memorizations version  
- fix error in iterative DP version  