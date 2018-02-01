title: "Tree Data Structure"
date: 2016-07-08 21:52:34
tags:
- BinaryTree
- BalancedTree
- BST
- TreeTraversal
- Recursion
---

# All about the Tree

![cover-image](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/binaryTree.bmp)

<!--more-->

## Advantage of Tree
- provides efficient **inssertion** and **search**  
- maintains level of **hierarchy**  
- reflects structural **relationships** in **data** (BST - values in left subtree smaller than root, while values in right subtree larger than root)  
- flexible data structure  

# Tree Traversals
- Traversal is a process of visiting all the nodes in a given tree.  
- There are two main type of traversal algorithms:  

1. depth-first traversal  
2. breath-first traversal (Level-Order)  

## Depth-First Traversal  

Three main types of depth-first traversal are available:  
- PreOrder Traversal  
- InOrder Traversal@  
- PostOrder Traversal  

> Note: **depth-limited searches** is a hybrid of both depth-first and breath first.

> @Note: in-order traversal on a **search tree** retreives data in **sorted** order).  

### Euler tour
- faster way to wirte out different order of depth-first traversal  

![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/traversalEuler.bmp)   

- each nodes were visited three times during the traversal  
- follow the purple lines to take the **tour**(you cannot cross the edges)  
- Each node will be visited either on the **left**, **below**, or **right**.  
- The Euler tour in which we visited nodes **on the left** produced **preorder traversal**.  
- When we visited nodes **under below** the nodes, we got **in-order traversal**.  
- When we visited nodes **on the right** of the nodes, we got **post-order traversal**.  

### Time complexity
The time complexity for all three traversal algorithm have run time of $O(n)$ where n is the number of nodes in the tree.  

Two explainations:  
1.The algorithm needs to visit **every node** $(n)$ exactly once $O(n)$.  
2.The algorithm needs to visit **every edges** $(n-1)$ exactly twices $O(2 (n - 1)) = O(n)$. 

### PreOrder Traversal
Parent value read **first**(Pre(first) -> parent, left, right)  

```java

    public ArrayList<Integer> preorderTraversal(TreeNode root) {
        // write your code here
        ArrayList<Integer> list = new ArrayList<Integer>();
        getValue(root, list);
        return list;
    }
    private void getValue(TreeNode root, ArrayList<Integer> list) {
        // base case
        if (root == null) {
            return;
        }
        // pre-oder traversal
        list.add(root.val);
        getValue(root.left, list);
        getValue(root.right, list);
        return;
    }
    
```

### InOrder Traversal (result in sorted order on search tree)
parent Value read in the **middle**(In -> left, parent, right)  

```java

    public ArrayList<Integer> inorderTraversal(TreeNode root) {
        // write your code here
        ArrayList<Integer> list = new ArrayList<Integer>();
        getValue(root, list);
        return list;
    }
    private void getValue(TreeNode root, ArrayList<Integer> list) {
        // base case
        if (root == null) {
            return;
        }
        // in-oder traversal
        getValue(root.left, list);
        list.add(root.val);
        getValue(root.right, list);
        return;
    }
    
```

### PostOrder Traversal
parent Value read in the end(Post -> last read -> left, right, parent)  

```java

    public ArrayList<Integer> postorderTraversal(TreeNode root) {
        // write your code here
        ArrayList<Integer> list = new ArrayList<Integer>();
        getValue(root, list);
        return list;
    }
    private void getValue(TreeNode root, ArrayList<Integer> list) {
        // base case
        if (root == null) {
            return;
        }
        // post-oder traversal
        getValue(root.left, list);
        getValue(root.right, list);
        list.add(root.val);
        return;
    }
    
```

### Preorder traversal (Iterative)

```java

    public ArrayList<Integer> preorderTraversal(TreeNode root) {
        // write your code here
        Stack<TreeNode> stack = new Stack<TreeNode>();
        ArrayList<Integer> preorder = new ArrayList<Integer>();
        if (root == null) {
            return preorder;
        }
        stack.push(root);
        while (!stack.empty()) {
            TreeNode curr = stack.pop();
            preorder.add(curr.val); // visit
            // LIFO / FILO
            if (curr.right != null) { // right, (right first since FILO)
                stack.push(curr.right);
            }
            if (curr.left != null) { // left
                stack.push(curr.left);
            }
        }
        return preorder;
    }

```

### Inorder traversal (Iterative)

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
class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        // write your code here
        
        // iterative approach
        List<Integer> list = new ArrayList<Integer>();
        Stack<TreeNode> stack = new Stack<TreeNode>();
        TreeNode curr = root;
        
        while (curr != null || !stack.isEmpty()) {
            while (curr != null) {
                stack.push(curr); // push left
                curr = curr.left;
            }
            curr = stack.pop(); // visit
            list.add(curr.val);
            curr = curr.right; // (push) right
        }
        return list;
    }
}
```

## Breath-First Traversal(Level-Order)  

There is only one type of Breath-First Traversal. The traversal visits nodes by levels from **top to bottom** and from **left to right**.  

### Implementation 

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


## Example: 

![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/tree1.bmp)
  
PreOrder - `8, 5, 9, 7, 1, 12, 2, 4, 11, 3`  
InOrder - `9, 5, 1, 7, 2, 12, 8, 4, 3, 11`   
PostOrder - `9, 1, 2, 12, 7, 5, 3, 11, 4, 8`   
LevelOrder - `8, 5, 4, 9, 7, 11, 1, 12, 3, 2`  



# Binary Tree
- a tree data structure that each node has **at most** two children.   
- The **depth** of a node is the number of edges from the **root** to **the node**.  
- The height of a **node** is the number of edges from **the node** to the **deepest leaf**.  
- The height of the **tree** is the number of edges from the **root** to the **deepest leaf**.  

## Full Binary Tree
Full binary tree is a binary tree in which **each node** has exactly **zero** or **two** children.    

![](http://7xihzu.com1.z0.glb.clouddn.com/20160712/full-tree.png)  

## Complete Binary Tree
A complete binary tree is a binary tree, which is completely filled, with the possible exception in the **bottom level** (partially filled), which is filled from **left to right**.  

![](http://7xihzu.com1.z0.glb.clouddn.com/20160712/complete-tree.png)  


# Binary Search Tree (BST)

The basic idea of binary search tree is to have such stroring repository to **search, insert, retrive** data.  

## Basic rules for Binary Search Tree:  
- each node contains **one** key (data)  
- **no** **duplicates** keys were allowed  
- key values in the left subtree must be **smaller** than the key value of its parent node.  
- key values in teh right subtree must be **larger** than the key value of its parent node.  

![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/pix03.bmp)  

## Insertion

Because of the $L<P<R$ structure maintains by the binary search tree. We will be easily insert new node by start from the root and recursively go down the tree for a location in BST to insert a new node.  

![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/insert.bmp)

> if the insert node was already exist in the BST, we simply return since BST does not allow duplicates.  


## Searching

Searching is similiar to the insertion. We start from the root of the tree and go down the tree by comparing the data value and either process to left or right of the BST depends on the result of the comparison of the data value.  

Searching in a BST has an average of $O(log(N))$ time complexity where $N$ is the number of nodes in the BST. However, the worst time complexity can be as high as $O(N)$ if the BST is not well balanced (extreme not height-balanced, liked linked-list).  



## Deletion

There are four cases need to consider for deletion:  
- the node is **not** in the tree  
- the node is a **leaf**  
- the node has **one** child  
- the ndoe has **two** children  

### node is **not** in the tree
The first case if node is not in the tree, we will not need to do much except the time spend to search for that node.  

### node is a **leaf**
In the second case when the node being delete is the leaf, we simply set that node to be `null`  

### node has **one** child 
If the node being deleted has **only** one child, we just need to set its parent's child to the child of the node that will be delete.  

![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/del01.bmp)  


### node has **two** children  
If the node being deleted has two children, we can swap it with the largest node to its left/ the smallest node to its right, and then deleted the node we intend to delete. 

> If the node being swapped performed the same operation according to each individual cases.  

![](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/del02.bmp)


# Balanced Tree

## Definition of height-balanced

### 1. Perfectly height-balanced tree**  
- left and right subtree of **any node** are the **same height**.  
- $H=O(logN)$  
- rare case since it need **exactly** $2^(H-1)$ nodes.  

![perfectly-height-balanced-tree](https://webdocs.cs.ualberta.ca/~holte/T26/Lecture9Fig9.gif)

### 2. Height-balanced tree  
- the height difference of left and right subtree of **every node** are within 1.  
- check **from leaves** and work your **way up**.  

![](https://webdocs.cs.ualberta.ca/~holte/T26/Lecture9Fig11.gif)

Node C and D are **perfectly balacned** since **height** of both left and right subtrees **are zeros** (same height).  

![](https://webdocs.cs.ualberta.ca/~holte/T26/Lecture9Fig12.gif)

work your way up and find out that node B's left subtree has height 1, while right subtree has height 0. The difference of left and right height is 1 (within 1). Therefore, subtree with root node B has is **height balanced**.  

![](https://webdocs.cs.ualberta.ca/~holte/T26/Lecture9Fig13.gif)

work your way up and find out that node A's left subtree has height 2, while right subtree has height 1. The difference of left and right height is still 1 (within 1). 

Since **all the nodes** in the tree maintain height-balanced property. This is a **height-balalnced** tree. 

> **Why** do we need height-balanced tree structure?   
> 
> Since most of the tree structure invovle data manipulation in form of **insert, delect, search** operations. The complexity of those operations are directly relate to the **height** of the tree. The most **optimal height** for a height-balance three is $H = O(Log(N))$, which is **smaller** than a unbalanced one. Therefore, maintaining a height-balanced tree structure (shorter height) means a better peroformance in doing those operations. 


# Find the height of tree structure  

```java 
    public int getHeight(TreeNode root) {
        if (rotot == null) {
            return 0;
        }
        if (root.left == null && root.right == null) {
            return 1;
        }
        int leftHeight = getHeight(root.left);
        int rightHeight = getHeight(root.right);
        return Math.max(leftHeight, rightHeight) + 1;
    }
```

# Logs: 
- 07/12/2016: BinaryTree, tree traversal, Binary Search Tree, Balanced Tree, find height of tree.  
- 07/15/2016: updated implementation for traversal algorithm(pre/in/post order traversal)  
- 07/15/2016: updated implementation for traversal algorithm(recursive & non-recursive)  
- 07/18/2016: updated implementation for level-order traversal  
- 10/22/2016: traversal algorithms complexity update  
- 01/07/2018: add iterative approach for preorder, inorder, 







# References:

[cover-image](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/pix/binaryTree.bmp) 
[Tree Traversals](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/trees.html)  
[CMU Binary Tree Intro](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Trees/trees.html)  
[3.1. Balanced Trees and images](https://webdocs.cs.ualberta.ca/~holte/T26/balanced-trees.html)  
