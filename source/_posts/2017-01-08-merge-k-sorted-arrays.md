title: "LC486 - merge k sorted arrays"
date: 2017-01-08 20:53:51
tags:
- LintCode
- DataStructure
- PriorityQueue
---


## <center> description </center>

Given *k* sorted integer arrays, merge them into one sorted array.

**Example**
Given 3 sorted arrays:

```
[
  [1, 3, 5, 7],
  [2, 4, 6],
  [0, 8, 9, 10, 11]
]
```

return `[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]`.

**Challenge**   
Do it in `O(N log k)`.

`N` is the total number of integers.  
`k` is the number of arrays.


[LC486 merge k sorted arrays](http://www.lintcode.com/en/problem/merge-k-sorted-arrays/#)

## <center> code </center>

### O(nlogk) ver.
$k$ is the number of arrays. $n$ is the total number of items.  
$O(nlogk)$ is an algorithm **better/faster** than $O(nlogn)$ version.  

```java
public class Solution {
    /**
     * @param arrays k sorted integer arrays
     * @return a sorted array
     */
    class Group {
        int row;
        int col;
        int val;
        public Group(int row, int col, int val) {
            this.row = row;
            this.col = col;
            this.val = val;
        }
    }
    private Comparator<Group> compare = new Comparator<Group>() {
        public int compare(Group a, Group b) {
            return a.val - b.val;
        }
    }; // semicolon to end a variable declaration
    
    public List<Integer> mergekSortedArrays(int[][] arrays) {
        // Write your code here
        Queue<Group> minQueue = new PriorityQueue<Group>(arrays.length, compare);
        List<Integer> sol = new ArrayList<Integer>();

        // initializaiton
        for (int i = 0; i < arrays.length; i++) {
            if (arrays[i].length == 0) return sol;
            Group curr = new Group(i, 0, arrays[i][0]);
            minQueue.offer(curr);
        }
        // algorithm
        while (minQueue.peek() != null) {
            Group min = minQueue.poll();
            int row = min.row;
            int col = min.col;
            if (col < arrays[row].length - 1) {
                Group curr = new Group(row, col+1, arrays[row][col+1]);
                minQueue.offer(curr);
            }
            sol.add(min.val);
        }
        return sol;
    }
}
```
<!--more-->

### O(nlogn) ver.
```java
public class Solution {
    /**
     * @param arrays k sorted integer arrays
     * @return a sorted array
     */
    public List<Integer> mergekSortedArrays(int[][] arrays) {
        // Write your code here
        Queue<Integer> minQueue = new PriorityQueue<Integer>();
        for (int i = 0; i < arrays.length; i++) {
            for (int j = 0; j < arrays[i].length; j++) {
                minQueue.offer(arrays[i][j]);
            }
        }
        List<Integer> sol = new ArrayList<Integer>();
        while(minQueue.peek() != null) {
            sol.add(minQueue.poll());
        }
        return sol;
    }
}
```

## <center> algorithm </center>
Instead of adding all the items in all arrays, we add ONLY the first elemnt of `k` array and select the smallest out of the `k` elements until all elements are added.   

The benefit of this modifcation is to reduce the time complexity of `poll` and `offer` opeartion from $O(log(n))$ to $O(log(k))$ where $k <= n$

**Note**: We always sacrifice **space** to imporve **time** **complexity**. In this case, we increase space for `<Group>` to stores more needed information.  



## <center> algorithm correctness </center>

Each iteration **add** one of the smallest element from k array and `minQueue` returns the smallest elements in the queue.  

## <center> complexity analysis </center>

Time: $O(nlogk)$ for improved version, and $O(nlogn)$ for the second ver.  
Space: $O(k)$ for storing $k$ element in `minQueue` for imporved ver.

## <center> self notes </center>

> You always need a semicolon to end a variable declaration, even if you are creating an instance of an anonymous class.

```java
    private Comparator<Group> compare = new Comparator<Group>() {
        public int compare(Group a, Group b) {
            return a.val - b.val;
        }
    }; // semicolon to end a variable declaration
```


## <center> application </center>
## <center> reference </center>

[semi after variable declaration for Comaprator instance ](http://stackoverflow.com/questions/17034661/generics-and-comparable-and-comparator-syntax-error-insert-to-complete-l)  
