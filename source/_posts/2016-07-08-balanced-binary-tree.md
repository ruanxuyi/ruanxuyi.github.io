title: "LintCode 93 - Balanced Binary Tree"
date: 2016-07-08 14:12:25
tags:
- BinaryTree
- LintCode
- BalancedTree
- Recursion
- LeetCode
---

[110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/description/)  
[93. Balanced Binary Tree](http://www.lintcode.com/en/problem/balanced-binary-tree/)

## Definition of Height balanced tree
1. empty tree is a height balanced tree  
2. left subtree is balanced, right subtree is balanced  
3. left/right sub-tree's height difference **no more than 1**    

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
     * @return: True if this Binary tree is Balanced, or false.
     */
    public boolean isBalanced(TreeNode root) {
        // write your code here
        return findHeight(root) != -1;
    }
    private int findHeight(TreeNode root) {
        // base case
        if (rotot == null) {
            return 0;
        }
        if (root.left == null && root.right == null) {
            return 1;
        }
        
        // progree toward base case
        int leftHeight = findHeight(root.left);
        int rightHeight = findHeight(root.right);
        if (leftHeight == -1 || rightHeight == -1 || Math.abs(leftHeight - rightHeight) > 1) {
            return -1;
        }
        return Math.max(leftHeight, rightHeight) + 1;
    }
}

```

<!--more-->

# Description:

Given a binary tree, determine if it is **height-balanced**.

For this problem, a height-balanced binary tree is defined as a binary tree in which the **depth** of the two subtrees of every node **never differ by more than 1**.

**Example**  
Given binary tree A = `{3,9,20,#,#,15,7}`, B = `{3,#,20,15,7}`

```
A)  3            B)    3 
   / \                  \
  9  20                 20
    /  \                / \
   15   7              15  7
```

The binary tree A is a height-balanced binary tree, but B is not.


# Thought Process:
- recursive algorithm  
- definition of **height-balanced** tree  
- post-order traversal (left, right, `Math.max()`)


**updated on: 2018-01-14**

# <center> algorithm </center>

## Recursive Algorithm:

Base cases:  
- `return 0` if `node == null`  
- `return 1` if `node.left == null && node.right == null`  
- `return -1` if differnece between left and right subtree height `> 1`

Progress toward basecase:  
- `int leftHeight = findHeight(node.left);`  
- `int rightHeight = findHeight(node.right);`  


# <center> complexity analysis </center>

## Recursive Algorithm:
Time complexity: $O(n)$ for traversing all nodes in tree  
Space complexity: $O(h)$ for maintaining recursive stack

where $n$ is number of nodes in tree, and $h=log(n)$ which is the height of the tree  

# <center> notes </center>
# <center> application </center>
# <center> reference </center>