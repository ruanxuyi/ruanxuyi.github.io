title: "LC547 - Intersection of Two Arrays"
date: 2017-01-04 16:07:04
tags:
- LintCode
- Array&Numbers
---


## <center> description </center>
Given two arrays, write a function to compute their intersection.  
Intersection指的是数学里的交集($\cap$)

**Notice**
Each element in the result must be unique.
The result can be in any order.

[LC547 Intersection of Two Arrays](http://www.lintcode.com/en/problem/intersection-of-two-arrays/)

## <center> code </center>
```java
public class Solution {
    /**
     * @param nums1 an integer array
     * @param nums2 an integer array
     * @return an integer array
     */
    public int[] intersection(int[] nums1, int[] nums2) {
        // Write your code here
        int len1 = nums1.length;
        int len2 = nums2.length;
        
        if (len1 == 0 || len2 == 0) {
            return new int[0];
        }
        HashSet<Integer> set = new HashSet<Integer>(); // checking
        HashSet<Integer> interset = new HashSet<Integer>(); // solution
        
        for (int i = 0; i < len1; i++) {
            set.add(nums1[i]);
        }
        for (int i = 0; i < len2; i++) {
            if (set.contains(nums2[i])) {
                interset.add(nums2[i]);
            }
        }
        int[] sol = new int[interset.size()];
        int index = 0;
        for (Integer num: interset) {
            sol[index++] = num;
        }
        return sol;
    }
}
```

<!--more-->

## <center> algorithm correctness </center>

Choose one of the array and add all its elements into a HashSet datastructure. HashSet only keeps single copy of the data disregard how many **duplicated** items are added. Since the question ask for unique intersect, we can simply use two hashSets: one for **checking** hashSet, another one **solution** hashSet.  

## <center> complexity analysis </center>

Assume `nums1.length == n` and `nums2.length == m`

`hashset.add()`: $O(1)$  
`hashset.contains()`: $O(1)$ 

**Time**: the first for loop cost $n \times O(1) = O(n)$ to add all items in `nums1` and second forloop costs $m \times O(1) = O(m)$ to check for intersection. The last forloop add all intersect items (less than either `n` or `m`) into an array `sol`.   
The total time complexity will be $O(n + m)$  

**Space**: total space complexity will be approx. $O(n + m)$  


## <center> self notes </center>

## <center> application </center>
To find the union $\cup$ of two arrays, simply add all items from both array into **one** HashSet.

## <center> reference </center>
[Java Collections – Performance (Time Complexity)](http://infotechgems.blogspot.com/2011/11/java-collections-performance-time.html)