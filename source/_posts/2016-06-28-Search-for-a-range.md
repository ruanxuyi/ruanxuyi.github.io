title: "Lintcode 61 - Search For a Range"
date: 2016-06-28 11:24:01
tags:
- BinarySearch
- LintCode
---

[Search for a Range](http://www.lintcode.com/en/problem/search-for-a-range/)  

# Code: 

```java
public int[] searchRange(int[] A, int target) {
        // write your code here
        int [] result = {-1, -1};
        if (A == null || A.length == 0) {
            return result;
        }
        int low = 0; 
        int mid = 0;
        int high = A.length - 1;
        int startPos = 0;
        int endPos = 0;
        boolean found = false;
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (target <= A[mid]) {
                high = mid;
            } else {
                low = mid;
            }
        }
        // binary search end
        if (A[low] == target) {
            startPos = low;
            found = true;
        } else if (A[high] == target) { // if the target value is the LAST element, using low as startPos will not work, in this case, set startPos as the index of LAST element. 
            startPos = high;
            found = true;
        } 
        if (found) {
            endPos = startPos;
            while (endPos < A.length && A[endPos] == target) {
                endPos++;
            }
            endPos--;
            result[0] = startPos;
            result[1] = endPos;
        }
        return result;
    }

```

<!--more-->

# Description: 

Given a sorted array of n integers, find the starting and ending position of a given target value.  

If the target is not found in the array, return `[-1, -1]`.  

**Example**: 
Given `[5, 7, 7, 8, 8, 10]` and target value `8`,
return `[3, 4]`.



# Thought Process: 
- Binary Search Algortihm  
- Duplication allowed  
- return the range of all target values(when duplicated) [Not return the first element found]    

`BinarySearch + duplication + return array of **range** of target value`  


> Depends on the type of data that you are working with, the alghrithm above will suffer if the duplicated target value is very long. (time complexity of traversing the duplicated target value high).   
> In this case, we prefer to perform binary search **twice** to find **low bound** & **high bound** seperately.  


# Corner Case:
- if arrray **size 0/null**  
- array has only **one element**  
- target is the **first** element `(startPos = low)`  
- target is the **last** element `(startPos = high)`  

