title: "LC138 - subarray sum"
date: 2017-01-04 11:33:00
tags:
- LintCode
- SBNN
- Array&Numbers
- Subarray
---


## <center> description </center>
Given an integer array, find a subarray where the sum of numbers is **zero**. Your code should return the index of the first number and the index of the last number.

 **Notice**
There is at least one subarray that it's sum equals to zero.

**Example**
Given `[-3, 1, 2, -3, 4]`, return `[0, 2] or [1, 3]`.

[LC138 subarray sum](http://www.lintcode.com/en/problem/subarray-sum/)

## <center> code </center>

### solution 3: $n$ summations
```java
public class Solution {
    /**
     * @param nums: A list of integers
     * @return: A list of integers includes the index of the first number 
     *          and the index of the last number
     */
    public ArrayList<Integer> subarraySum(int[] nums) {
        // write your code here
        ArrayList<Integer> res = new ArrayList<Integer>();
        HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        map.put(0, -1);
        int len = nums.length;
        int sum = 0;
        for (int i = 0; i < len; i++) {
            sum += nums[i];
            if (map.containsKey(sum)) {
                res.add(0, map.get(sum) + 1);
                res.add(1, i);
                return res;
            }
            // add to map
            map.put(sum, i);
        }
        return res;
    }
}
```

<!--more-->

### solution 2 from [LC139 - subarray sum closest](http://xuyiruan.com/2017/01/02/Subarray-Sum-Closest/)

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
    public ArrayList<Integer> subarraySum(int[] nums) {
        
        // write your code here
        ArrayList<Integer> res = new ArrayList<Integer>(2);
        if (nums.length <= 1 || nums == null) {
            res.add(0, 0);
            res.add(1, 0);
            return res;
        }
        if (nums.length == 2) {
            res.add(0, 0);
            res.add(1, 1);
            return res;
        }
        int len = nums.length;
        int max = Integer.MAX_VALUE;

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
                res.clear(); // prevent multple solution
                res.add(0, Math.min(nums_aux[i].index, nums_aux[i+1].index));
                res.add(1, Math.max(nums_aux[i].index, nums_aux[i+1].index) - 1);
            }
        }
        return res;        
    }
}
```

## <center> algorithm correctness </center>

### solution 1: 
two for-loop traverse all possible sub-array

### solution 2: 
exact same alghorthm as [LC139 - subarray sum closest](http://xuyiruan.com/2017/01/02/Subarray-Sum-Closest/)

### solution 3: $n$ summations
Take the summation of the array of size `n` by indices enclosed: `[0]`, `[0,1]`, `[0,2]`,...,`[0,n]`, and store them as `<sum, end_index>` pair into a `hashMap`.  

**Example**: 
`[1, 3, 2, -3, 1, 6]`

`sum1` = `1`  
`sum2` = `1+3` = `4`  
`sum3` = `1+3+2` = `6`  
`sum4` = `1+3+2-3` = `3`  
`sum5` = `1+3+2-3+1` = `4`  
`sum6` = `1+3+2-3+1+6` = `11`  

we notice `sum2` and `sum5` are indentical. by **subtracting** `sum5` with `sum2` we got `0`, which is the exact sum of subarray `[2,-3,1]` where it sums up to `0`.  

if there exists a subarray where the sum of numbers is zero, there must be two identical sums appeared. (`sum2 + 0 = sum5`)

Therefore, we only need to add all summuations to a HashMap and detect the duplicate sum.  
 
## <center> complexity analysis </center>
### solution 1: 
**time**: $O(n^2)$  
**space**: $O(1)$
### solution 2: 
exact same alghorthm as [LC139 - subarray sum closest](http://xuyiruan.com/2017/01/02/Subarray-Sum-Closest/)

### solution 3: 
**time**: $O(n)$ take a total number of $n$ summations     
**space**: $O(n)$ to store $n$ sums

## <center> self notes </center>
## <center> application </center>
## <center> reference </center>
[Sol by jiuzhang](http://www.jiuzhang.com/solutions/subarray-sum/)