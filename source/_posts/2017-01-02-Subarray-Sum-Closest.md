title: "LC139 - subarray sum closest"
date: 2017-01-02 14:57:20
tags:
- LintCode
- Subarray
- Array&Numbers
- SBNN
---


## <center> description </center>
Given an integer array, find a subarray with sum closest to zero. Return the indexes of the first number and last number.
**Example**  
Given `[-3, 1, 1, -3, 5]`, return `[0, 2]`, `[1, 3]`, `[1, 1]`, `[2, 2]` or `[0, 4]`.  

**Challenge**   
O(nlogn) time

[LC139 subarray sum closest](http://www.lintcode.com/en/problem/subarray-sum-closest/)

## <center> code </center>
```java
public class Solution {
    /**
     * @param nums: A list of integers
     * @return: A list of integers includes the index of the first number 
     *          and the index of the last number
     */
    class NSum {
        int sum;
        int index;
        public NSum(int s, int i) {
            this.sum = s;
            this.index = i;
        }
    }
    public int[] subarraySumClosest(int[] nums) {
        // write your code here
        if (nums.length <= 1 || nums == null) {
            return new int[]{0,0};
        }
        if (nums.length == 2) {
            return new int[]{0,1};
        }
        int len = nums.length;
        int max = Integer.MAX_VALUE;
        int[] res = new int[2];
        NSum[] nums_aux = new NSum[len + 1];
        nums_aux[0] = new NSum(0, 0);
        
        // get sum
        for (int i = 1; i <= len; i++) {
            nums_aux[i] = new NSum(nums[i-1] + nums_aux[i-1].sum, i);
        }
        // sort O(nlogn)
        Arrays.sort(nums_aux, new Comparator<NSum>(){
            public int compare(NSum a, NSum b) {
                return a.sum - b.sum;
            }
        });
        for (int i = 0; i < len; i++) {
            if (Math.abs(nums_aux[i+1].sum - nums_aux[i].sum) < max) {
                max = Math.abs(nums_aux[i+1].sum - nums_aux[i].sum);
                res[0] = Math.min(nums_aux[i].index, nums_aux[i+1].index);
                res[1] = Math.max(nums_aux[i].index, nums_aux[i+1].index) - 1;
            }
        }
        return res;
    }
}

```
<!--more-->

## <center> algorithm correctness </center>

requirment: $O(nlogn)$ -> sorting  
apply sorting on `nums` -> not helpful, original order disorder -> subarray **broken**  

Example: 
$[-3, 1, 3, -2, 4]$

all the possible combination of **sub-array** for particular example above include:  
start with $1st$ element $-3$:  $[-3]$, $[-3, 1]$, $[-3,1,3]$, $[-3, 1, 3, -2]$, and $[-3, 1, 3, -2, 4]$  
start with $2nd$ element $1$:  $[1]$, $[1, 3]$, $[1, 3, -2]$, and $[1, 3, -2, 4]$  
start with $3rd$ element $3$:  $[3]$, $[3, -2]$, and $[3,-2,4]$  
start with $4th$ element $-2$: $[-2]$, $[-2,4]$  
start with $5th$ element $4$:  $[4]$  

![](http://7xihzu.com1.z0.glb.clouddn.com/20170102/1.png)

All the combination above could possiblely sum up to value close to zero. We calculate all the sum for combination above and return the one that is closest to zero.  

### 解法一 two for-loops: 

```java
for (int i = 0; i < len; i++) {
	for (int j = i; j < len; j++) { // j = i -> single element should also be considered
		// calculate and record max sum
		
	}
}
```
### 解法二 改进版 $n$ summations + sorting:

Second approach works like this:   

1.calculate sum of index of array: 

`sum1 = [0]`,   
`sum2 = [0, 1]`,  
`sum3 = [0, 1, 2]`,   
`sum4 = [0, 1, 2, 3]`,   
...  
`sum_n = [0, 1, ... n]`.  


![我爱学编程](http://7xihzu.com1.z0.glb.clouddn.com/20170104/0.jpg)

Pictures from [我爱学编程](http://www.wtoutiao.com/p/1f7JM8B.html)

2.sort `[sum1, sum2, sum3, ... sum_n]`  

![我爱学编程](http://7xihzu.com1.z0.glb.clouddn.com/20170104/1.jpg)
Pictures from [我爱学编程](http://www.wtoutiao.com/p/1f7JM8B.html)

3.subtract adjacent sorted sum and return smallest one.  

**Observation**

Lets revisit the graph we saw above  
![](http://7xihzu.com1.z0.glb.clouddn.com/20170102/1.png)  
Instead of populate **all** the possible combinations, we only need to and find the subarray that possible lead to value cloes to zero.  

Indeed, we **only** need to calculate the $n$ sum. The sum of rest sub-array could be calculate by the **subtraction** of two of the $n$ sum.  

**For example:**   
we know sum of `[-3, 1, 3, -2]` is `-1`. we also know sum of `[-3, 1]` is `-2`. we can find sum of subarray `[3, -2]` by taking subtraction of calculated sum, `-1` and `-2` we get teh sum of subarray  `[3, -2]` is `1`. we can validate $3-2$ is indeed $1$.  

The reason of sorting on sum: is to **avoid** doing **un-necessary** calculation that will not lead to a sum that is closed to zero.  

**Sorting** on sum (avoid uncessary calculation) and **taking subtraction** (get sum for rest of subarrays) on adjacent sums ensures the sums of subarray are **as close to zero as** possible.  


## <center> complexity analysis </center>

### 解法一 two for-loops: 
**time**: $O(n^2)$ for traversing two for loops  
**space**: $O(1)$ no extra space required  
### 解法二 $n$ summations + sorting
**time**: $O(nlogn) + O(n) = O(nlogn)$.  
$O(n)$ for calcuating $n$ sum. $O(nlogn)$ for sorting on $n$ sum.  for traversing two for loops  
**space**: $O(n)$ extra space required to store object of $n$ sums.

[github]()

## <center> application </center>
## <center> self notes </center>
## <center> reference </center>
[我爱学编程 最接近零的子数组和 Subarray Sum Closest](http://www.wtoutiao.com/p/1f7JM8B.html)  