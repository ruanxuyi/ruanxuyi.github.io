title: Binary Search
date: 2016-03-28 14:35:52
updated: 2016-03-28 14:35:52
tags: 
- BinarySearch
- Array
categories: DataStructure

---


LeetCode #33

Tag: binary search, array, 

# **Binary Search**

1. In-order list. 
2. If not in-order -> sort the list with `quick sort` first and apply binary search.

## **Binary Search Implementation:**

### 1: check the validaite of low and high


### 2: prevent overflow
算法一： mid = (low + high) / 2

算法二： mid = low + (high – low) / 2

乍看起来，算法一简洁，算法二提取之后，跟算法一没有什么区别。但是实际上，区别是存在的。算法一的做法，在极端情况下，(low + high)存在着溢出的风险，进而得到错误的mid结果，导致程序错误。而算法二能够保证计算出来的mid，一定大于low，小于high，不存在溢出的问题。


二分算法的实现中，我们更期望的是向下取整, 算法二保证向下取整。

low + high < 0时，如low = -3, high = 2时，计算出来的中点是0。
然而用low + (high – low) / 2计算出来的中点是-1。

算法二: 向下取整。(ex. 1.5 －> 1, -0.5 -> -1)  
算法一: mid 是向0取整: (ex. 1.5 -> 1, -0.5 -> 0)  

为了避免 向0取整 用算法二。

<!--more-->


### 3: prevent using recursion: 

slow, dont use it??

maybe use up too many system resource??


## **Regular Binary Search Templete**

```java
	public static int binarySearch(int[] nums, int target) {
		if (nums == null || nums.length == 0) 
			return -1;
		int low = 0;
		int mid = 0;
		int high = nums.length - 1;
		while (low <= high) {
			mid = low + (high - low) / 2;
			if (nums[mid] == target) {
				return mid;
			} else if (target < nums[mid]){
				high = mid - 1;
			} else {
				low = mid + 1;
			}
		}
		return -1;
	}

```

## **Search in Rotated Sorted Array**


Suppose a sorted array is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

You are given a target value to search. If found in the array return its index, otherwise return -1.

You may assume no duplicate exists in the array.


**Solution 1: Iteration (in linear time complexity)**


```java
public class Solution {
	public int search(int[] nums, int target) {
		if (nums == null || nums.length == 0)
			return -1;
		for (int i = 0; i < nums.length; i++) {
			if (nums[i] == target)
				return i;
		}
		return -1;
		}
}
```


**Solution 2: Binary Search (time complexity in log(N))**

```java
public class Solution {
    public int search(int[] nums, int target) {
        if (nums == null || nums.length == 0)
            return -1;
        int low = 0;
        int mid = 0;
        int high = nums.length - 1 ;
        while (low <= high) {
            mid = low + (high - low)/2;
            if (target == nums[mid])
                return mid;
            // if nums[low] < nums[mid] -> this portion in-order-> can apply binary search
            else if (nums[low] <= nums[mid]) {
                if (target < nums[mid] && target >= nums[low])
                    high = mid - 1;
                else
                    low = mid + 1; // nums[low] = nums[mid] case
            }
            // if nums[low] >= nums[mid] -> other protion in-order
            else {
            //if (nums[low] > nums[mid]) {
                if (target > nums[mid] && target <= nums[high])
                    low = mid + 1;
                else
                    high = mid - 1;
            } 
        }
        return -1;
    }
}
```

**Solution 3: Binary Search with recursion**

 ```java
 /**
 * Recursion with binary search
 * 
*/
public class Solution {
    public int search(int[] nums, int target) {
        return binarySearch(nums, target, 0, 0, nums.length-1);
    }
    
    public int binarySearch(int[] nums, int target, int low, int mid, int high){
        if (nums == null || nums.length == 0)
            return -1;
        if (low <= high) {
            mid = low + (high - low)/2;
            if (target == nums[mid])
                return mid;
                // if nums[low] < nums[mid] -> this portion in-order-> can apply binary search
            else if (nums[low] <= nums[mid]) {
                if (target < nums[mid] && target >= nums[low])
                    return binarySearch(nums, target, low, mid, mid - 1);
                else
                    return binarySearch(nums, target, mid + 1, mid, high);
            }
            // if nums[low] >= nums[mid] -> other protion in-order
            else {
                //if (nums[low] > nums[mid]) {
                if (target > nums[mid] && target <= nums[high])
                    return binarySearch(nums, target, mid + 1, mid, high);
                else
                    return binarySearch(nums, target, low, mid, mid - 1);
            } 
        } else {
            return -1;
        }
    }
    
}
 
 ```




**拓展: Allow of duplication**

In the previous case, if `nums[low] <= nums[mid]`, we knows that [low, mid] is in a ordered sequence ([2, 3, 4, 5] for example). 
BUT now with duplication allowed, this no longer hold (`[1, 1, 3, 1]` with `low = 1`, `mid = 1`). if we still image `[1, 1, 3, 1]` is an ordered sequency (since nums[low] <= nums[mid]), we will not be able to notice `target 3` is in this sequence. Hence, now we need to be careful with condition `nums[low] <= nums[mid]`.

Lets break this condition into two cases:   
1. when `nums[low] < nums[mid]`  
In this case, we are confident that [low, mid] is a increasing ordered sequence. We can apply binary search on [low, mid] to locate the target value.   
2. when `num[low] == nums[mid]`  
In this case, since duplications are allowed, we don't know if `[low, mid]` sequence is still an ordered increasing list. Therefore we can not be determine if target value is within `[low, mid]`. Hence, we simply increment the `low` pointer and cotinue with the algorithm.

In this case, the time complexity will increase if the number of duplicated elements are large. Other than that, the time complexity will stay similar if not many duplications is in the sequence.


```java
public class Solution {
    public boolean search(int[] nums, int target) {
        if (nums == null || nums.length == 0)
            return false;
        int low = 0;
        int mid = 0;
        int high = nums.length - 1 ;
        while (low <= high) {
            mid = low + (high - low)/2;
            if (target == nums[mid])
                return true;
            // if nums[low] < nums[mid] -> this portion in-order-> can apply binary search
            else if (nums[low] < nums[mid]) {
                if (target < nums[mid] && target >= nums[low])
                    high = mid - 1;
                else
                    low = mid + 1; // nums[low] = nums[mid] case
            } else if (nums[low] == nums[mid]) {
                // account for duplication
                low++;
            } else { // if nums[low] > nums[mid] -> other protion in-order
                if (target > nums[mid] && target <= nums[high]) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            } 
        }
        return false;
    }
}
```

给定一个升序排列的自然数数组，数组中包含重复数字，例如：[1,2,2,3,4,4,4,5,6,7,7]。问题：给定任意自然数，对数组进行二分查找，返回数组正确的位置，给出函数实现。注：连续相同的数字，返回第一个匹配位置还是最后一个匹配位置，由函数传入参数决定。



Reference: 



http://blog.csdn.net/maqingli87/article/details/8009186

[Binary Search](http://hedengcheng.com/?p=595)
[duplication allowed] (http://www.2cto.com/kf/201401/272968.html)
