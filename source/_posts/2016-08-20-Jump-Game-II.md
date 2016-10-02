title: "LintCode 117 - Jump Game II"
date: 2016-08-20 16:15:34
tags:
- LintCode
- DP
- H
- Greedy
---

[Jump Game II](http://www.lintcode.com/en/problem/jump-game-ii/)

# Code: 

## V0 Greedy

```java
public class Solution {
    /**
     * @param A: A list of lists of integers
     * @return: An integer
     */
    public int jump(int[] A) {
        // write your code here
        if (A == null || A.length == 0) {
            return -1;
        }
        int start = 0, end = 0, jumps = 0;
        while (end < A.length - 1) {
            jumps++;
            int tempFar = end;
            for (int i = start; i <= end; i++) {
                if (A[i] + i > tempFar) {
                    tempFar = A[i] + i;
                }
            }
            start = end + 1;
            end = tempFar;
            // if the array is not reachable to the end.
            // prevent infinite loop, which test case assume all array reachable
            if (start > end) { 
                break;
            }
        }
        return jumps;
    }
}

```

## V1 DP

```java 

public class Solution {
    /**
     * @param A: A list of lists of integers
     * @return: An integer
     */
    public int jump(int[] A) {
        // write your code here
        if (A == null || A.length == 0) {
            return -1;
        }
        int[] steps = new int[A.length];
        steps[0] = 0;
        // DP: steps[] stores minmum steps to that location
        for (int i = 1; i < A.length; i++) {
            steps[i] = Integer.MAX_VALUE;
            for (int j = 0; j < i; j++) {
                if (steps[j] != Integer.MAX_VALUE && A[j] + j >= i) {
                    steps[i] = steps[j] + 1;
                    break;
                }
            }
        }
        return steps[A.length - 1];
    }
}


```


<!--more-->

## My Code (first draft) 

```java 

public class Solution {
    /**
     * @param A: A list of lists of integers
     * @return: An integer
     */
    public int jump(int[] A) {
        // write your code here
        if (A == null || A.length == 1) {
            return 0;
        }
        int farthest = A[0];
        int minJump = 0;
        int maxRange = A.length - 1;
        int currIndex = 1;
        boolean done = false;
        while (!done) {
            if (currIndex > maxRange) {
                return 0;
            }
            minJump++;
            if (farthest >= maxRange) {
                done = true;
            }
            int tempFar = farthest;
            while (currIndex <= farthest && currIndex <= maxRange) {
                //System.out.println("here");
                if (A[currIndex] + currIndex > tempFar) {
                    tempFar = A[currIndex] + currIndex;
                }
                currIndex++;
            }
            farthest = tempFar;
        }
        return minJump;
    }
}


```

# Description: 

Given an array of non-negative integers, you are initially positioned at the first index of the array.  

Each element in the array represents your maximum jump length at that position.  

Your goal is to reach the last index in the minimum number of jumps.  

**Example**
Given array `A = [2,3,1,1,4]`

The minimum number of jumps to reach the last index is `2`. (Jump `1` step from index 0 to 1, then `3` steps to the last index.)



# Thought Process:

## Greedy Approach

In the **current** range [`start, end`], we are looking for the **farthest jump** we can take in that current range `[start, end]`, and increment `jumps`. Then we update the **new range** with `start = end + 1` and `end = tempFar` until we reach the last index of the array.  

## DP Approach
- the initialization step for `steps[i] = Integer.MAX_VALUE` serve as a mark for  location that is not reachable. It is possible to use other distinguish notation, such as `steps[i] = -1` or ``steps[i] = 99999999` to mark the un-reachable loaction.  
-  if `steps[i] = Integer.MAX_VALUE`, for location `i`, we dont need to check any locations those are larger/further than location `i`. Since we are not able to reach `i`, we are not likely to reach anything futher than `i`.  

```java
        // steps[i] was calculate from steps[j]+1 (j < i)
        // where i is the first location that can reach to location i.
```

# Corner Case:
- in DP approach, code line 18:  

```
    if (steps[j] != Integer.MAX_VALUE && A[j] + j >= i) {
```
- Previously, mistakenly use `A[j] + j > i` for first try. The meaning behind `A[j] + j >= i` said if i can reach to `i` OR further than `i`, I will perform the update.  


# Reference

[Solution by Jiuzhang](http://www.jiuzhang.com/solutions/jump-game-ii/)  
[dijkstra最短路径来解de灵感](http://fisherlei.blogspot.com/2012/12/leetcode-jump-ii.html)