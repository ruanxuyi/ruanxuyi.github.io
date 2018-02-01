title: "LC41 - maximum subarray"
date: 2017-01-02 15:20:18
tags:
- LintCode
- Subarray
- Array&Numbers
- SBNN
- DP
---


## <center> description </center>

Given an array of integers, find a contiguous subarray which has the largest sum.

**Notice**  
The subarray should contain at least one number.

**Example**  
Given the array `[−2,2,−3,4,−1,2,1,−5,3]`, the contiguous subarray `[4,−1,2,1]` has the largest `sum = 6`.

[LC41 maximum subarray](http://www.lintcode.com/en/problem/maximum-subarray/)

## <center> code </center>
```java
public class Solution {
    /**
     * @param nums: A list of integers
     * @return: A integer indicate the sum of max subarray
     */
    public int maxSubArray(int[] nums) {
        // write your code
        // double loop -> n^2
        // sort? nlogn NO
        
        int max = Integer.MIN_VALUE; // if all negative values, return the smalleset neg val
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            max = Math.max(sum, max);
            sum = Math.max(0, sum); // if sum of prev elements less than zero, rather not taken them.
        }
        return max;
    }
}
```

<!--more-->

## <center> algorithm correctness </center>
### DP Approach

we iterate through the entire array and iteratively collect the `max` subarray sum up to that point.  

At every iteration:  
`sum = sum + nums[i];` // nums[i] is current inspected element   

we have following **two conditions**:  

- 1) if adding `nums[i]` results in `sum` to **negative** value ($sum < 0$), we reset `sum=0`.  

If the sum of prev elements are smaller than 0, we can simply discard them and reset sum to 0.  

`line 16: sum = Math.max(0, sum);`

if all the numbers given are negative, we still need to return the largest of all negative numbers. line 15 of the code does that. 

`line 15: max = Math.max(sum, max);`

- 2) if adding `nums[i]` results in `sum` became/remain **positive**($sum>0$), we **keep** the current sum value to next iteration.  

There are **two cases** for $sum(new) > 0$:  

- 2a) `sum(new)` larger than current `max`: **keep** current `sum` to next iteration and **update** `max` value.

- 2b) `sum(new)` larger than 0, but smaller than current `max`: **keep** current `sum` to next iteration but **NO** update on `max` value.  

In this case, we record the current sum to next iteration, if later we have a larger value and add up to a  `sum` which is larger than current `max`, when we update `max` at that time. 

> Note: if we use an array to record `max` values of every iteration. we will able to recall subarray max sum up to the corresponding index of array (Dynamic Programming).  

## <center> complexity analysis </center>

time: $O(n)$ takes one scan for entire array of n elements  
space: $O(1)$ constant space required. (dp approach require O(n) space)

[github]()

## <center> application </center>

## <center> self notes </center>
## <center> reference </center>

[九章](http://www.jiuzhang.com/solutions/maximum-subarray/)  
