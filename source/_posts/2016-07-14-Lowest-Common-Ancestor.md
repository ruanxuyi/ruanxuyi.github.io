title: "LintCode 88 - Lowest Common Ancestor"
date: 2016-07-14 15:06:48
tags:
- LintCode
- Divide&Conquer
- BinaryTree
- Recursion
---

[Lowest Common Ancestor](http://www.lintcode.com/en/problem/lowest-common-ancestor/)  

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
     * @param root: The root of the binary search tree.
     * @param A and B: two nodes in a Binary.
     * @return: Return the least common ancestor(LCA) of the two nodes.
     */
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode A, TreeNode B) {
        // write your code here
        // base case
        if (root == null || root.val == A.val || root.val == B.val) {
            return root;
        }
        // divide
        TreeNode left = lowestCommonAncestor(root.left, A, B);
        TreeNode right = lowestCommonAncestor(root.right, A, B);
        // conquer
        if (left != null && right != null) {
            return root;
        }
        if (left != null) {
            return left;
        }
        if (right != null) {
            return right;
        }
        return null;
    }
}

```

<!--more-->

# Description:
 
Given the root and two nodes in a Binary Tree. Find the lowest common ancestor(LCA) of the two nodes.  

The lowest common ancestor is the node with largest depth which is the ancestor of both nodes. 

**Example:**

For the following binary tree:

```
  4
 / \
3   7
   / \
  5   6
```

LCA(3, 5) = `4`

LCA(5, 6) = `7`

LCA(6, 7) = `7`

# Thought Process:

This question invovles usage of divide and conquer. Since we are doing **recursive** call to the same funciton, we need to fisrt come up with its **base cases**. Basic cases serve as an end point for the recursive function call. Once return from the base case, we process to the **divide and conquer** section. Within the divide section, the same activation record (same recursive process), `TreeNode left` **will wait** until `TreeNode right` has a valid value. (this waiting step is essential to understand the idea of recursive function) A valid value could be either `null`, or a TreeNode with values data in this example.  

Once both left and right TreeNode has a return value from the **previous** recurrsive call. We can process to the **conquer** section to determine the lowest common ancestor.  
 

# Refernce: 

[Solution by Jiuzhang](http://www.jiuzhang.com/solutions/lowest-common-ancestor/)

