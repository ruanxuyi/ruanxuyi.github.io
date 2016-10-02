title: "Lintcode 447 - Search in a Big Sorted Array"
date: 2016-06-28 11:57:06
tags:
- BinarySearch
- LintCode
---

[Search in a Big Sorted Array](http://www.lintcode.com/en/problem/search-in-a-big-sorted-array/)  

# Code: 


```java
    public int searchBigSortedArray(ArrayReader reader, int target) {
        // write your code here
        if (reader == null) {
            return -1;
        }
        int low = 0;
        int mid = 0;
        int high = target;
        /**
         *  second tries added
         */
        while (reader.get(high) < target) {
            high += target;
        }
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (target <= reader.get(mid)) {
                high = mid;
            } else {
                low = mid;
            }
        }
        if (reader.get(low) == target) {
            return low;
        }
        if (reader.get(high) == target) {
            return high;
        }
        return -1;
    }
```

<!--more-->

# Description: 
Given a big sorted array with positive integers sorted by ascending order. The array is so big so that you can not get the length of the whole array directly, and you can only access the kth number by `ArrayReader.get(k)` (or `ArrayReader->get(k)` for C++). Find the first index of a target number. Your algorithm should be in O(log k), where k is the first index of the target number.

Return `-1`, if the number doesn't exist in the array.

>  Notice:  
> If you accessed an inaccessible index (outside of the array), ArrayReader.get will return `2,147,483,647`.
> 
> 

**Example**:   
Given `[1, 3, 6, 9, 21, ...]`, and `target = 3`, return `1`.

Given `[1, 3, 6, 9, 21, ...]`, and `target = 4`, return `-1`.



# Thought Process: 
## 考点一: 找high bound
当不能直接得到binary search the range 的时候(此题不能直接用nums.length得到higher bound)，需要通过间接方式猜测high bound. 此题中的的array是有序的。如果是个有序(in-order)且连续(consecutive)的array 
`[0,1,2,3,4,5,6,7...]`
则index 对应的就是相应的数值。如果这个array不是连续(consecutive)的。用target来做index 很有可能得到的就是这个binary search的high bound.
`[0,2,3,4,6,8,9,13...]` 当`target = 6` 我们用target做high index, `reader.get(target)`returns `9`, which is a good choice for high index. 

## 考点二: 元素的重复性(duplications)
由于此题没有明确说明不允许重复元素的出现。
`[1,1,1,1,1,1,1,1,1,1,1,1,1,4]` target = 4
如果出现这种情况下, `reader.get(target) =1`就不会是这个binary search的high bound, 因此我们应该将target * 2 ＝ 8, 如果还是不行可以继续乘下去。直到out of bound (return 一个很大的，比target 要大很多的数) 或者找到比target 数值大的index即可。

上面是因为重复元素导致的找high index的一些处理。真正的duplication binary search 需要处理的code 在下面.
之前的情况是不允许duplication的
`[2,2,3] 当low = 0, mid = 1, high = 2` 

的情况下, 按照模版一(无duplication的情况下), 程序会直接return mid= 1 的值。可是我门想得到的是**第一个**match的target 的index。很显然，这个情况下第一个match的index应该是在index ＝ 0的时候。

因此我们需要在判断的时候做一个小改动。把`target == reader.get(mid)`的情况归属到`high = mid`。为什么归属到`high = mid` 而不是归属到`low = mid`. 仔细想想上面[2,2,3]的例子，如果用`low = mid` 的话新的low就会得到新的数值 `low = 1` 明显违背了正确答案return 0 index的宗旨。因此如果需要return index of the **first** target value, 则需要`high = mid`.

因此如果题目要求return `first match`的index, 我应该**移动high index**. 所以需要把reader.get(mid) == target 的情况放在`high = mid`的case中。(要第一个index 所以我可以移动**后面**的index，update high index)。

如果题目要求return `last match`的index, 这个时候你就要想，我应该**移动low index**, 你需要把reader.get(mid) == target 的情况放在`low = mid`的case中。(要找最后一个match 的index 所以我可以移动**前面**的index，update low index)。


# Corner Case:
- array == null  
- duplication allowed  

# Failed Code: 

## First try: use `target` as high index.
```java
public class Solution {
    /**
     * @param reader: An instance of ArrayReader.
     * @param target: An integer
     * @return : An integer which is the index of the target number
     */
    public int searchBigSortedArray(ArrayReader reader, int target) {
        // write your code here
        if (reader == null) {
            return -1;
        }
        int low = 0;
        int mid = 0;
        int high = target;
        while (low + 1 < high) {
            mid = low + (high - low) / 2;
            if (target < reader.get(mid)) {
                high = mid;
            } else if (target > reader.get(mid)) {
                low = mid;
            } else {
                // target == reader.get(mid)
                return mid;
            }
        }
        if (reader.get(low) == target) {
            return low;
        }
        if (reader.get(high) == target) {
            return high;
        }
        return -1;
    }
}
```

## Error: did not consider duplicates. 

```
Input
[1,1,1,1,2,2,3,3,3,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,10,10,10,10,10,11,11,11,11,12,12,12,13,13,13,13,13,14,14,14,14,14,15,15,15,15,15,15,15,16,16,16,16,16,16,16,16,16,17,17,17,17,17,17,17,18,18,19,19,19,19,20,20,20,20,20,20,20,20,20], 4
```

Output
-1
Expected
9