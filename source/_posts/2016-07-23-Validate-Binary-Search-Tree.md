title: "LintCode 95 - Validate Binary Search Tree"
date: 2016-07-23 20:15:42
tags:
- LintCode
- BST
- Recursion
- H
- Divide&Conquer
---

[Validate Binary Search Tree](http://www.lintcode.com/en/problem/validate-binary-search-tree/#)  

# Code: 

**Version 1: Recursive**

```java

public class Solution {
    /**
     * @param root: The root of binary tree.
     * @return: True if the binary tree is BST, or false
     */
    public boolean isValidBST(TreeNode root) {
        return isValidBST(root, Double.NEGATIVE_INFINITY, Double.POSITIVE_INFINITY);
        //return isValidBST(root, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }
    public boolean isValidBST(TreeNode p, double min, double max){
        if(p == null) {
            return true;
        }
        if(p.val <= min || p.val >= max) {
            return false;
        }
        return isValidBST(p.left, min, p.val) && isValidBST(p.right, p.val, max);
    }
}

```

**Version 2: Iterative (with Helper function - recommanded)**

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
     * @return: True if the binary tree is BST, or false
     */
    public boolean isValidBST(TreeNode root) {
        // write your code here
        if (root == null) {
            return true;
        }
        Queue<BNode> queue = new LinkedList<BNode>();
        queue.offer(new BNode(root, Double.NEGATIVE_INFINITY, Double.POSITIVE_INFINITY));
        while (!queue.isEmpty()) {
            BNode curr = queue.poll();
            if (curr.node.val <= curr.minVal || curr.node.val >= curr.maxVal) {
                return false;
            }
            if (curr.node.left != null) {
                queue.offer(new BNode(curr.node.left, curr.minVal, curr.node.val));
            }
            if (curr.node.right != null) {
                queue.offer(new BNode(curr.node.right, curr.node.val, curr.maxVal));
            }
        }
        return true;
    }
}

class BNode {
    TreeNode node;
    double minVal;
    double maxVal;
    public BNode (TreeNode node, double minVal, double maxVal) {
        this.node = node;
        this.minVal = minVal;
        this.maxVal = maxVal;
    }
}

```


<!--more-->





# Description: 

Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

- The left subtree of a node contains only nodes with keys **less than** the node's key.  
- The right subtree of a node contains only nodes with keys **greater than** the node's key.  
- Both the left and right subtrees must also be binary search trees.  
- A single node tree is a BST  


**Example**
An example:

```java
  2
 / \
1   4
   / \
  3   5
```

The above binary tree is serialized as `{2,1,4,#,#,3,5}` (in level order).  


# Thought Process:

## Version 1: Recursive (DFS)

In the first implementation, I focused **too many steps** in a single recursion (Not only checking `root.val` but also checking `root.left` and `root.right`'s validity).  

Instead, we simply need to focus on root's validity at single recursion with `min` and `max` limitation set by previous recursion.  

## Version 2: Iterative (BFS) Recommanded

In case of long left subtree, the version above will suffer in bad time complexity by going through whole left subtree fisrt before exploring the right subtree. If the violation occurs close to the root on the right subtree. Method 1 will cost `O(n)`.  

In this case, we would like to iterative from top to bottom level of the tree. In case of whose left subtree was significantly **longer** than right subtree, and the **violation** is at right-subtree, iterative version will possible catch the violation in the early stage without went through all the nodes on left-subtree.   
 

# Corner Case:

The test case actually have a single test case like following:  

{2,147,483,647} which is exactly $2^{31}-1$. Because of that, we could not use `Integer.MAX_VALUE`, which is $2^{31}-1$. Instead, we could use `Double.POSITIVE_INFINITY` to prevent failing this specific test case.  

# Fail Trail: 

```java

public class Solution {
    /**
     * @param root: The root of binary tree.
     * @return: True if the binary tree is BST, or false
     */
    private int rightMin = Integer.MAX_VALUE;
    private int leftMax = Integer.MIN_VALUE;
    public boolean isValidBST(TreeNode root) {
        // write your code here
        // base case
        if (root == null) {
            return true;
        }
        leftMax = root.val;
        rightMin = root.val;
        boolean leftResult = validate(root.left, true);
        boolean rightResult = validate(root.right, false);
        return leftResult && rightResult;
    }
    private boolean validate(TreeNode root, boolean isLeftTree) {
        if (root == null) {
            return true;
        }
        if (isLeftTree && root.val > leftMax) {
            leftMax = root.val;
        }
        if (!isLeftTree && root.val < rightMin) {
            rightMin = root.val;
        }
        
        // divide
        boolean leftResult = validate(root.left, isLeftTree);
        boolean rightResult = validate(root.right, isLeftTree);
        // conquer
        
        if (root.left != null) {
            leftResult = leftResult && (root.left.val < root.val) && root.left.val < leftMax;
        }
        if (root.right != null) {
            rightResult = rightResult && (root.right.val > root.val) && root.right.val > rightMin;
        }
        return leftResult && rightResult;
    }
}

```

# Reference: 

[LeetCode – Validate Binary Search Tree (Java) ](http://www.programcreek.com/2012/12/leetcode-validate-binary-search-tree-java/)