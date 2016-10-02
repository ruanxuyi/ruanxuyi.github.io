title: "LintCode 448 - Inorder Successor in Binary Search Tree"
date: 2016-07-13 10:45:40
tags:
- LintCode
- BST
---

[Inorder Successor in Binary Search Tree](http://www.lintcode.com/en/problem/inorder-successor-in-binary-search-tree/)

# Code: 

```java 

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public TreeNode inorderSuccessor(TreeNode root, TreeNode p) {
        // write your code here
        // locate node P and mark the deepest ancestor which p locates in its LEFT-subtree
        TreeNode successor = null;
        while (root != null && root != p) {
            if (root.val > p.val) {
                successor = root;
                root = root.left;
            } else {
                root = root.right;
            }
        }
        if (root == null) {
            return null;
        }
        // case 1: p has NO right child
        if (root.right == null) {
            return successor;
        }
        // case 2: p has right child
        root = root.right;
        // locate far-left node (smallest value in right subtree)
        while (root.left != null) {
            root = root.left;
        }
        // return far-left node if left child exists
        // otherwise, return right child of node p.
        return root;
    }
}

```


<!--more-->

# Description: 

Given a binary search tree (See Definition) and a node in it, find the in-order successor of that node in the BST.

If the given node has no in-order successor in the tree, return `null`.

> **Notice**:  
> It's guaranteed p is one node in the given tree. (You can directly compare the memory address to find p)  

## Example
Given tree = `[2,1]` and node = `1`:

```
  2
 /
1
```

return node `2`.

Given tree = `[2,1,3]` and node = `2`:

```
  2
 / \
1   3
```

return node `3`.

# Thought Process:
In-order successor is the **next node** that will be visit after node `p` with the **in-order traversal** algorithm.  

The reason that we care about in-order-successor in that we are usually interesting in knowing the data **before** and **after** the given target data. Therefore, we need an **efficient algorithm** to find both **successor** and **predecessor** of the target data.  

We can definitly find the successor by performing the complete in-order traversal while that will be not be efficient ($O(N)$ time complexity). We can implement more efficient algorithm to finish the task in ($O(log(N))$) time complexity.  

## Steps: 
### 1. Search the target node (p).
Since the data store in BST data structure, we are able to locate the target node from top of the tree with $O(log_2(N))$ time complexity, where $N$ is the number of nodes in the BST.  

### 2. Case 1: if p has NO right child
If target node p has NO right child, the next node visit will be one of its **deepest** ancestor, which p is in the **left subtree** of the ancestor.  

> **deepest ancestor:**  
> the **depth** of a tree is number of edges from root to given node. Therefore, the deepest ancestor will likely be the one **furthest** from the root node and fulfill the left-subtree requirement.  

node p has no right child, and deepest ancestor node 8, which node 7 (target) is in the left-sub tree of the ancestor, therefore, node 8 will be the successor in this example.  


```
           10 <- root
          /
         9 
        /
       8 <- successor
      /
     4
      \
       7 <- target node p
```
node p has no right child, and deepest ancestor node 4, which node 3 (target) is in the left-sub tree of the ancestor, therefore, node 4 will be the successor in this example. 

```
           10 <- root
          /
         9 
        /
       8 
      /
     4 <- successor
    /
   3 <- target node p

```

### 3. Case 2: if p has right child

If target node p has right child, the next node (**successor**) will visit according to the in-order traversal algorithm **locates** **in the right-subtree** of the target node.  


```
           10 <- root
           /
          9 
         /
        8 <- successor
       /
      4 <- target node p
       \
        7    }
       / \   } right subtree of node p
          ...}
```

we need to find the **far-left node** in the right subtree until we reach the far-left child (**smallest** node in the right subtree) in the right-subtree. That far-left node is the next node we will visit (successor).  

```
           10 <- root
           /
          9 
         /
        8 
       /
      4 <- target node p
       \
        7     }
       / \    } right subtree of node p
      6   ... }
     /
    5  <- successor (far-left node in right subtree)
```

Otherwise, if there is NO left-child, we will **next visit** the **right child of the target node p**. Simply return the right child of the target node p. `return p.right`  

```
           10 <- root
           /
          9 
         /
        8 
       /
      4 <- target node p
       \
        7 <- successor     }
         \                 } right subtree of node p
         ...               }
	
     
```

# Corner Case:

# Reference: 

[Solution by Jiuzhang](http://www.jiuzhang.com/solutions/inorder-successor-in-binary-search-tree/)  
[Youtube walk-through](https://www.youtube.com/watch?v=5cPbNCrdotA)
