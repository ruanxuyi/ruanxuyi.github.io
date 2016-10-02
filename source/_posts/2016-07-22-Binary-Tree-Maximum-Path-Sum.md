title: "LintCode 94 - Binary Tree Maximum Path Sum"
date: 2016-07-22 17:14:17
tags:
- LintCode
- BinaryTree
- Divide&Conquer
- Recursion
- H
---

[Binary Tree Maximum Path Sum](http://www.lintcode.com/en/problem/binary-tree-maximum-path-sum/)

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
import java.lang.Integer;

public class Solution {
    /**
     * @param root: The root of binary tree.
     * @return: An integer.
     */
    int max = Integer.MIN_VALUE;
    public int maxPathSum(TreeNode root) {
	    calculateSum(root);
	    return max;
    }
 
    public int calculateSum(TreeNode root) {
	    if (root == null) {
		    return 0;
	    }
    	int leftSum = calculateSum(root.left);
	    int rightSum = calculateSum(root.right);
	    int current = Math.max(root.val, Math.max(root.val + leftSum, root.val + rightSum));
	    // updat max value
	    max = Math.max(max, Math.max(current, leftSum + root.val + rightSum));
    	// return sum to parents
    	return current;
    }
}

```

<!--more-->

# Description: 

Given a binary tree, find the maximum path sum.

The path may start and end at any node in the tree.

**Example**  
Given the below binary tree:

```java
  1
 / \
2   3
```

return 6.

# Thought Process:

This problem is particular interesting, since the max path is not limited with any start and end point.  

- Break problem into smaller pieces (fundmental parts).    
- The fundmental part for this problem build with, `root`, `root.left`, and `root.right`  

```java
// fundmental unit
		root
		/	\
root.left	 root.right
(leftSum)   (rightSum)

Note: leftSum and rightSum from previous recursive
```

- Second step is try to figure out how does the fundemental part contribute/affect the whole tree structure.  

Within the fundemental unit, the max sum for that unit could be one of the following(max of them):  
- `root.val`  
- `root.val + leftSum`  
- `root.val + rightSum`

We returned the max of the three above to the previous recursive call.  

One last step: Since the max path could start and end in **any** nodes of the tree. It could be the case that max path connect both paths with the same LCA(lowest common ancester). Therefore, we should also record `root.val + rightSum + leftSum` seperately.  


# Corner Case:


# Reference:

[LeetCode – Binary Tree Maximum Path Sum (Java)](http://www.programcreek.com/2013/02/leetcode-binary-tree-maximum-path-sum-java/)
