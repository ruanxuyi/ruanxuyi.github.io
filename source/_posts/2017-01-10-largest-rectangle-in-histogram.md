title: "LC122 - largest rectangle in histogram"
date: 2017-01-10 23:21:45
tags:
- LintCode
- SBNN
- Stack
- Array
- DataStructure
---


## <center> description </center>

Given $n$ non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.

![](http://www.lintcode.com/media/problem/histogram1.png)

Above is a histogram where width of each bar is 1, given height = `[2,1,5,6,2,3]`.

![](http://www.lintcode.com/media/problem/histogram_area.png)

The largest rectangle is shown in the shaded area, which has area = `10` unit.

**Example**
Given height = `[2,1,5,6,2,3]`,
return `10`.

[LC122 largest rectangle in histogram](http://www.lintcode.com/en/problem/largest-rectangle-in-histogram/)

## <center> code </center>
```java
public class Solution {
    /**
     * @param height: A list of integer
     * @return: The area of largest rectangle in the histogram
     */
    public int largestRectangleArea(int[] height) {
        // write your code here
        Stack<Integer> stack = new Stack<Integer>();
        int max = 0;
        for (int i = 0; i <= height.length; i++) {
            int curr = i == height.length ? 0 : height[i];
            while (!stack.empty() && curr < height[stack.peek()]) {
                int right = i;
                int target = stack.pop();
                int left = stack.empty() ? -1 : stack.peek();
                int area = (right - left - 1) * height[target];
                max = area > max ? area : max;
            }
            stack.push(i);
        }
        return max;
    }
}
```
<!--more-->

## <center> algorithm </center>

### Method1 ($O(n^2)$)

For each target bar, two pointers scan away from the **target bar** to left and right until reaching the first bar with smaller height OR pointer reach the end of array. Calculate **max area** with height of target bar and return the global `max` value.  

### Method2 ($O(n)$)

From observing method 1, we can eliminate un-necessary scan opeartion by maintaining a increment sequence in stack.  

For example, given array `array = [1 2 3 4 5 6]`.  

To find area of `bar 0 = a[0]`: since the height of bars are in increment order, we scan from left to right and visit 5 bars to its right.  
To find area of `bar 1 = a[1]`: we scan from left to right visit the **same bars** visited last iteration.     
We repeat the process above until we find area for all the bars.  

#### benefit of incremental order

Notice of the **duplicate** scan of same bars for mulitple times from left to right in an height increment array. We **avoid duplicate** scan by utilizing a stack to record the index of current increment sequence until we hit a bar which its height is not continue incrementing.  

Another **benefit** of maintaing a incremental order is it provide a general format for calculating the area. If elements in an incremental sequence index from $i$ to $j$, the **widith** of max area with height of `bar[i]` must extends to `j`. 

`int area = (j - i + 1) * height[target];`


**Algorithm**:   

```
for (int i = 0; i <= height.length; i++)
    If (current bar height $>$ the bar height pushed previously) (maintaining increment order): 
	     -> push into stack  
    While (current bar height $<$ the bar height pushed previously) (current element will distroy increment property):  
        -> pop from top of stack  
        -> calculate area of height of pop element and update `max`
```
Instead of scaning from left to right for n times, this algorithm only requires 1 scan from left to right.  


## <center> complexity analysis </center>
### method 1
**Time**:  $O(n^2)$ for each bar, we need $O(n)$ to find the max area of with that height, and we have total of $n$ bars.  
**Spcce**:  $O(1)$ no extra space required

### method 2
**Time**:  $O(n)$ only require one scan from left to right accross each bar.  
**Spcce**:  $O(n)$ extra space for stack to store the incrementing sequence.  


## <center> self notes </center>

Another interesing by [geeksforgeeks.com](http://www.geeksforgeeks.org/largest-rectangular-area-in-a-histogram-set-1/) has $O(nlogn)$ with Divide and Conquer + Segment Tree.  
## <center> application </center>
## <center> reference </center>
[Sol by Jiuzhang](http://www.jiuzhang.com/solutions/largest-rectangle-in-histogram/)  
[非常中肯的分析](http://bangbingsyb.blogspot.com/2014/11/leetcode-largest-rectangle-in-histogram.html)  