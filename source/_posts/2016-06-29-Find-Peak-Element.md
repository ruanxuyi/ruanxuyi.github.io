title: "LintCode 75 - Find Peak Element"
date: 2016-06-29 10:31:10
tags:
- BinarySearch
- LintCode
---

[Find Peak Element](http://www.lintcode.com/en/problem/find-peak-element/#)  

# Code: 

## Binary Search Version (O(Log(N)))

```java
    public int findPeak(int[] A) {
        // write your code here
        if (A == null || A.length == 0) {
            return -1;
        }
        if (A.length == 1) {
            return 0;
        }
        int low = 0;
        int mid = 0;
        int high = A.length - 1;
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (A[mid] < A[mid - 1]) { // 6 5 4 当发现有descend的时候, 将high index 往左缩进。
                high = mid;
            } else { // 4 5 6 其他的时候，因为最后array最后肯定有peak, 因此update low index 往右缩进。
                low = mid;
            }
            // since A[0] < A[1] && A[A.length - 2] > A[A.length - 1].
            // therefore, there must be a peak in at the end of the array. 
            // that is the reason we set low = mid;
        }
        if (low >= 1) {
            if (A[low] > A[low - 1] && A[low] > A[low + 1]) {
                return low;
            }
        } 
        if (high < (A.length - 1)) {
            if (A[high] > A[high - 1] && A[high] > A[high + 1]) {
                return high;
            }
        }
        return -1;
```

<!--more-->

## Traversal Version (O(N))  

```java
        int currIndex = 1;
        while (currIndex < A.length - 1) {
            if (A[currIndex] > A[currIndex - 1] && A[currIndex] > A[currIndex + 1]) {
                return currIndex;
            }
            currIndex++;
        }
```






# Description:

There is an integer array which has the **following features**:

- The numbers in adjacent positions are different.  
- A[0] < A[1] && A[A.length - 2] > A[A.length - 1].  
We define a position P is a peek if:

`A[P] > A[P-1] && A[P] > A[P+1]`
Find a peak element in this array. Return the index of the peak.  

> **Notice**:    
> The array may contains multiple peeks, find any of them.

**Example**  
Given `[1, 2, 1, 3, 4, 5, 7, 6]`

Return index `1` (which is number 2) or `6` (which is number 7)


# Thought Process:
- since it has at least one peak, and we **clearly** know the peak will be near the end of the array.  
- we use binary search algorithm to find location where array descend (which mean peak exists on the left side of the `middle` index).  
- otherwise, we goes to the right half of the array, since we know there exist a peak at the end of the array.  
- we continue the binary search process and finally validate the peak.  
 
I was not able to come up with a binary search algorithm at first. 

I mistenly understand the problem that we need to find **all** the possible peaks. Therefore, the first algortihm came up with and passed the test was a traversal algorithm. 

However, after careful understand of the problem, it only ask for **either one** of the peak from the array. Then I was able to come up with an algorithm using Binary Search to lower down the time complexity to `log(N)`. 

Since binary search need follloing two requirements: 
- sorted array  
- given target value to search  

Since we were not given an target value to search for, but we still can narrow down the possible location of the peak by comparing value of the elements right next to the middle index `(mid-1 & mid +1)`. By this way, we are able to take advantage of the BS algorithm to narrow down the possible range for possible peak values.  


> HOW to make sure dont miss the case where
[1,2,1,3,4,5,6,7] ???what if you go to the right, then you miss peak =2 on the left, right?? 


OK.. Please read the question more careful. The second feature indicates that `A[0] < A[1] && A[A.length - 2] > A[A.length - 1]` 


# Corner Case:
NA

