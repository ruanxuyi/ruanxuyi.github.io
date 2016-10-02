title: "LintCode 28 - Search a 2D Matrix"
date: 2016-07-01 11:27:35
tags:
- BinarySearch
- LintCode
---

[Search a 2D Matrix](http://www.lintcode.com/en/problem/search-a-2d-matrix/)  

# Code: 
```java
    public boolean searchMatrix(int[][] matrix, int target) {
        // write your code here
        if (matrix == null || matrix.length == 0) {
            return false;
        }
        int rowLow = 0;
        int rowMid = 0;
        int rowHigh = matrix.length - 1;
        int rowIndex = 0;
        int colLow = 0;
        int colMid = 0;
        int colHigh = matrix[0].length - 1;
        while (rowLow + 1 < rowHigh) {
            rowMid = rowLow + (rowHigh - rowLow) / 2;
            if (target < matrix[rowMid][0]) {
                rowHigh = rowMid;
            } else if (target > matrix[rowMid][0]) {
                rowLow = rowMid;
            } else {
                return true;
            }
        }
        if (target > matrix[rowLow][0] && target < matrix[rowHigh][0]) {
            rowIndex = rowLow;
        } else if (target > matrix[rowHigh][0]) {
            rowIndex = rowHigh;
        } else if (target == matrix[rowLow][0] || target == matrix[rowHigh][0]){
            return true;
        } else {
            // (target < matrix[rowLow][0]
            return false;
        }
        while (colLow + 1 < colHigh) {
            colMid = colLow + (colHigh - colLow) / 2;
            if (target < matrix[rowIndex][colMid]) {
                colHigh = colMid;
            } else if (target > matrix[rowIndex][colMid]) {
                colLow = colMid;
            } else {
                return true;
            }
        }
        if (target == matrix[rowIndex][colLow] || target == matrix[rowIndex][colHigh]) {
            return true;
        } else {
            return false;
        }
        
    }
```

<!--more-->

# Description: 
Write an efficient algorithm that searches for a value in an `m x n` matrix.  

This matrix has the following properties:  

- Integers in each row are sorted from left to right.  
- The first integer of each row is greater than the last integer of the previous row.  

**Example**  
Consider the following matrix:
```
[
    [1, 3, 5, 7],
    [10, 11, 16, 20],
    [23, 30, 34, 50]
]
```
Given `target = 3`, return `true`.


# Thought Process:
- binary search algorithm 
- **2D-array** matrix length/size  
- perform binary search **two times**  
- first binary search **find** the possible target's **row index**    
- second binary search **find** the possible **column index**  

# Corner Case:
- `matrix == null || matrix.length == 0`  


