title: "LC148 - sort colors"
date: 2016-12-29 21:04:48
tags:
- Array&Numbers
- Sorting
- TwoPtrs
- LintCode
---

## <center>description</center>    
Given an array with n objects colored red, white or blue, sort them so that objects of the same color are adjacent, with the colors in the order red, white and blue.

Here, we will use the integers `0`, `1`, and `2` to represent the color red, white, and blue respectively.


> Notice  
You are not suppose to use the library's sort function for this problem. 
You should do it in-place (sort numbers in the original array).

**Example**
Given `[1, 0, 1, 2]`, sort it in-place to `[0, 1, 1, 2]`.  

**challenge**  
**one pass** algorithm with constant space ($O(1)$)

[LC148 sort colors](http://www.lintcode.com/en/problem/sort-colors/#)

## <center>code</center>    

### ver3 one pass  

```java
    public void sortColors(int[] nums) {
        // write your code here
        if (nums.length <= 1 || nums == null) {
            return;
        }
        int low = 0;
        int high = nums.length - 1;
        int curr = 0;
        while (curr <= high) { // k1: curr == high 时候 high points to unchecked value
            if (nums[curr] == 0) {
                // swap with nums[left]
                nums[curr] = nums[low]; // curr should NOT increment to prevent skipping after swap
                nums[low++] = 0;
                curr++; // k2: swapped value from left pointer is checked.
            } else if (nums[curr] == 2) {
                // swap with nums[right]
                nums[curr] = nums[high];
                nums[high--] = 2;
                // NO curr++: swaped value from right pointer is unchecked, 
                // curr pointed value (uncheck) needed to be checked
            } else {
                curr++;
            }
        }
    }
```


<!--more-->

### ver2 [count sort] two passes
```java
    public void sortColors(int[] nums) {
        // write your code here
        if (nums.length <= 1) {
            return;
        }
        // count sort aux array
        int[] count = new int[3];
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 0) {
                count[0]++;
            } else if (nums[i] == 1) {
                count[1]++;
            } else {
                count[2]++;
            }
        }
        
        int index = 0;
        for (int i = 0; i < count.length; i++) {
            int total = count[i];
            while (total != 0) {
                nums[index] = i;
                index++;
                total--;
            }
        }
    }
```

### ver1:

```java
    public void sortColors(int[] nums) {
        // write your code here
        if (nums.length <= 1) {
            return;
        }
        int left = 0;
        int right = nums.length - 1;
        
        int[] sorted = new int[nums.length];
        for (int i = 0; i < nums.length; ++i) {
            sorted[i] = 1;
        }
        for (int i = 0; i < nums.length; ++i) {
            if (nums[i] == 0) {
                sorted[left] = 0;
                ++left;
            }
            if (nums[i] == 2) {
                sorted[right] = 2;
                --right;
            }            
        }
        for (int i = 0; i < nums.length; ++i) {
            nums[i] = sorted[i]; 
        }
    }
}
```

## <center>algorithm correctness</center>    

### key 0: decomposition of the array  

![](http://7xihzu.com1.z0.glb.clouddn.com/20161229/1.png)


### key 1: when `(curr == high)`    

![](http://7xihzu.com1.z0.glb.clouddn.com/20161229/3.png)

line9:`while (curr <= high) { `

why not (`while (curr < high)`) ? 

when `(curr == high)`, `high` points to **unchecked value**. while loop need to check value currently pointed by `curr` before exit.  

### key 2: curr increment on swap w/ `nums[low]`, but NOT on swap w/ `nums[high]`  

![](http://7xihzu.com1.z0.glb.clouddn.com/20161229/2.png)

`curr` increment on swap w/ `nums[low]` becasue `low` points to value already **checked**. (no need to check after swap).   
however. `curr` **NOT** increment on swap w/ `nums[high]` becuase `high` points to value **NOT** checked. (need to be checked after swap).  


## <center>complexity analysis</center>    

v1: (time: $O(n)$, space: $O(n)$)  
v2: (time $O(n)$, space: $O(1)$) two passes   
v3: (time $O(n)$, space $O(1)$) one pass  

## <center>self notes</center>    
复习key points:  
1. ++i vs i++  
2. idea of **checked** AND **unchecked** value/portion  


## <center>reference</center>  

附上一个v3 注意点分析的不错的博客[Yu's garden](http://www.cnblogs.com/yuzhangcmu/p/4048668.html)

