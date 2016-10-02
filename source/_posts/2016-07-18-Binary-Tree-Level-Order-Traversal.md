title: "Binary Tree Level Order Traversal"
date: 2016-07-18 15:36:29
tags:
- LintCode
- BinaryTree
---

[Binary Tree Level Order Traversal](http://www.lintcode.com/en/problem/binary-tree-level-order-traversal/)

# Code: 

```java
/**
 * Definition of TreeNode:
 * public class TreeNode {
 *     public int val;
 *     public TreeNode left, right;
 *     public TreeNode(int val) {
 *         this.val = val;
 *         this.left = this.right = null;
 *     }
 * }
 */
 
 
public class Solution {
    /**
     * @param root: The root of binary tree.
     * @return: Level order a list of lists of integer
     */
    public ArrayList<ArrayList<Integer>> levelOrder(TreeNode root) {
        // write your code here
        Queue<TreeNode> queue = new LinkedList<TreeNode>();
        Queue<TreeNode> queueInner = new LinkedList<TreeNode>();
        ArrayList<ArrayList<Integer>> result = new ArrayList<ArrayList<Integer>>();
        if (root == null) {
            return result;
        }
        queue.offer(root);
        while (queue.peek() != null || queueInner.peek() != null) {
            while (queue.peek() != null) {
                queueInner.offer(queue.poll());
            }
            ArrayList<Integer> currList = new ArrayList<Integer>();
            while (queueInner.peek() != null) {
                TreeNode curr = queueInner.poll();
                currList.add(curr.val);
                if (curr.left != null) {
                    queue.offer(curr.left);
                }
                if (curr.right != null) {
                    queue.offer(curr.right);
                }
            }
            result.add(currList);
        }
        //System.out.println("hi");
        return result;
    }
}
```

<!--more-->

# Description: 

Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).  

**Example**  
Given binary tree `{3,9,20,#,#,15,7}`,

```
    3
   / \
  9  20
    /  \
   15   7
```

return its level order traversal as:

```
[
  [3],
  [9,20],
  [15,7]
]
```


# Thought Process:

Original use non-recursive approach from pre-order traversal. Instead of using `stack` (LIFO) data structure, level-order traversal requires a different data structure - `queue`. Queue is a First In First Out (FIFO) data structure. 

## Key Point 1:
Stack is a `class` in java, which could be directly instantiate with `new` statement. Queue is an **interface**, which could not be directly used to instantiate as an instance. Instead, we need to use other underline data structure to implement the queue. The most common and the one we are going to use is `LinkedList`.  

`Queue<TreeNode> queue = new LinkedList<TreeNode>();`

TODO: The technique above is call xxxx. Refer to my other post [here](xxxx) for details. 

## Key Point 2:
The return type of this problem is `ArrayList<ArrayList<Integer>>`, which reuqires us to seperates values by level. This will require little extra thoughts into the implementation. We need to **first** retrieve all the nodes those are in the same level from the queue, and add those values as a sepearte `ArrayList`. At the same time, we also need to add all predecessors into the queue for further traversal.  

To implement the above funtion to seperate nodes from current level to the next level, I used two queues: **one** for processing all the nodes in the smae level, **the other** queue stores all predecessors in the relative order for next level.  

# Corner Case:
My first submit failed to consider the `null` node's effect to queue's `offer()` method. 

```java
            while (queueInner.peek() != null) {
                TreeNode curr = queueInner.poll();
                currList.add(curr.val);
                queue.offer(curr.left);
                queue.offer(curr.right);
            }

```


A `null` node will be added to the queue, which will affect jugement of the while loop statement.  

```java
while (queue.peek() != null || queueInner.peek() != null) 
```

Since I don't want `null` node be added to the queue. I simply added if statement to prevent that from happening.  


```java

            while (queueInner.peek() != null) {
                TreeNode curr = queueInner.poll();
                currList.add(curr.val);
                if (curr.left != null) {
                    queue.offer(curr.left);
                }
                if (curr.right != null) {
                    queue.offer(curr.right);
                }
            }

``` 

