title: "LC533 - two sum closest"
date: 2016-12-29 19:34:50
tags:
- Array&Numbers
- TwoPtrs
- LintCode
---


## <center>description</center>  
Given an array `nums` of n integers, find two integers in nums such that the sum is closest to a given number, target.

Return the difference between the sum of the two integers and the target.


**Example**
Given array `nums = [-1, 2, 1, -4]`, and `target = 4`.

The minimum difference is `1`. (4 - (2 + 1) = 1).


[LC533 Two Sum Closest](http://www.lintcode.com/en/problem/two-sum-closest/#)


## <center>code</center>    
```java
    public int twoSumCloset(int[] nums, int target) {
        // Write your code here
        if (nums.length < 2 || nums == null){
            return -1;
        }
        Arrays.sort(nums); // o(nlogn)
        int left = 0;
        int right = nums.length - 1;
        int minDif = Integer.MAX_VALUE;
        
        while (left < right) {
            int twoSum = nums[left] + nums[right];
            //int currDif = Math.abs(target - twoSum);
            //minDif = currDif < minDif ? currDif : minDif;
            if (twoSum < target) {
                left++;
            } else {
                right--;
            }
            minDif = Math.min(minDif, Math.abs(target - twoSum);
        }
        return minDif;
    }
```

<!--more-->

## <center>algorithm correctness</center>    
Why the algorithm is correct?  
given `nums = [1, 2, 4, 6, 8, 12, 13, 15]` and  `target = 17`;  

if `left` points to `value = 4`, at next iteration, `left` points to `value = 6`. it always checks the adjecent values (16 and 18) of `target = 17`. It is sufficient to determine `minDif` for **fixed** right pointer's value.

## <center>complexity analysis</center>    
- **time** $O(NlogN)$ for dual-pivot quick sort and $O(N)$ for traversing entire array. total time complexity: $O(NlogN)$
- **space** $O(1)$

## <center>self notes</center>    

复习key points:   
1. first try忽略点: 只需要return minDiff，不需要return具体数  
2. don’t always use [x = y ? a: b] 善用Math.min  
3. Integer.MAX_VALUE;  
4. Arrays.sort 复杂度了解 dual-pivot quick sort  
5. review quick sort algorithm  