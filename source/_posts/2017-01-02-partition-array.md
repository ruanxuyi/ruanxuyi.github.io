title: "LC31 - partition array"
date: 2017-01-02 12:17:39
tags:
- LintCode
- Array&Numbers
- Sorting
---

## <center> description </center>
Given an array `nums` of integers and an int `k`, partition the array (i.e move the elements in "nums") such that:  

All elements < k are moved to the *left*  
All elements >= k are moved to the *right*  
Return the partitioning index, i.e the first index *i* nums[*i*] >= *k*.  

**Example**  
If nums = `[3,2,2,1]` and `k=2`, a valid answer is `1`.

[LC31 - partition array](http://www.lintcode.com/en/problem/partition-array/)  

## <center> code </center>
```java
public class Solution {
	/** 
     *@param nums: The integer array you should partition
     *@param k: As description
     *return: The index after partition
     */
    public int partitionArray(int[] nums, int k) {
	    //write your code here
	    if (nums.length == 0 || nums == null) {
	        return 0;
	    }
	    int low = 0;
	    int high = nums.length-1;
	    while (low <= high) {
	        while (low <= high && nums[low] < k) {
	            low++;
	        }
	        while (low <= high && nums[high] >= k) {
	            high--;
	        }
	        // swap
	        if (low <= high) {
	            int tmp = nums[high];
	            nums[high] = nums[low];
	            nums[low] = tmp;
	            //low++;
	            //high--;
	        }
	    }
	    return high+1;
    }
}
```
<!--more-->

## <center> algorithm correctness </center>
### line 14 : `while (low <= high) {`, why `low < high` is not sufficient?  

partition algorithm requires partition to be done as following:  
`[start... high] [low... end]` where `low != high`  
Therefore, when `low == high`, we need to further seperate `low` with `high` to fullfill the inclusive requirement.  

### line 15 & line 18: why extra `low <= high`?  

different from partition in quicksort algorithm, where pivot `p` at most the **largest** or **smallest** element **in** the array.(ex `[1,2,3]`, `p = 2`).   

However, in this particular setting, integer `k` could be either larger/smaller than **any** of the elements in the array. (ex. `[1,2,3]` `k = 4`).  
Without `low <= high` condition inside `while` statement, `low++`/`high--` will cause index-out-of-bound.  

### line 26, 27 is optional in this question.  

	            //low++;
	            //high--;
	            
two lines above inside if statment is optional in this setting because while statement from line 18-20 **update** `high pointer` when the value is equal to the target value (pivot value).  

However, this two lines are **essential** in quicksort becuase both while loop in quick sort did not specific what to do when `value == pivot`. 

```java
		while (array[left] < pivot) {
			left++;
		}
		while (pivot < array[right]) {
			right--;
		}
```
Therefore, **without** two lines in if statemnt below. At time encounter values **equal** to pivot value, algorithm will **NOT** progress.  

```java
		if (left <= right) {
			int temp = array[right];
			array[right] = array[left];
			array[left] = temp;
			left++; // help to progress w/ piviot == array[left]
			right--; // help to progress w/ piviot == array[right]
		}
```
## <center> complexity analysis </center>
time $O(n)$ where n is the number of elements in array  
space $O(1)$ no extra space needed

[github]()

## <center> self notes </center>
quick sort algorithm - PARTION 部分的 变种。  
1. int `k`, is not neccessary part of array, `k` could be larger/smaller than any of elements in array.  add `low < nums.length` on line 15 and `high >= 0` on line 18 to prevent indexOutOfBound.  
2. `nums[high] >= k` put all values equal to **pivots** values to the right partion to fulfill the requirement.  


## <center> reference </center>
[九章Partition Array](http://www.jiuzhang.com/solutions/partition-array/)  
[Sorting Algorithm](http://xuyiruan.com/2016/08/30/Sorting-Algorithms/)  
