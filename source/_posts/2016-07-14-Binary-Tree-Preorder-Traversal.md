title: "LintCode 66 - Binary Tree Preorder Traversal"
date: 2016-07-14 16:12:25
tags:
- LintCode
- TreeTraversal
- BinaryTree
- ArrayList
- Divide&Conquer
- Recursion
---

[Binary Tree Preorder Traversal](http://www.lintcode.com/en/problem/binary-tree-preorder-traversal/)

# Code: 

## Version 0 (Non-recursion Stack) - Recommend

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
     * @return: Preorder in ArrayList which contains node values.
     */
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
            preorder.add(curr.val);
            // LIFO / FILO
            if (curr.right != null) {
                stack.push(curr.right);
            }
            if (curr.left != null) {
                stack.push(curr.left);
            }
        }
        return preorder;
    }
}

```

<!--more-->

Recursive algorithm has following advantage and disadvantages: 

**Pros:** 
- elegant, easy to read code.  
- tree traversal problem easier   

**Cons:**
- take more stack space with lots of activation records 
- use lots of memory  
- run slower  

[Link: Recursion-vs-Iteration](http://xuyiruan.com/2016/07/15/Recursion-vs-Iteration/)

## Version 1 (Divide-and-Conquer)

```java

public class Solution {
    /**
     * @param root: The root of binary tree.
     * @return: Preorder in ArrayList which contains node values.
     */
    public ArrayList<Integer> preorderTraversal(TreeNode root) {
        // write your code here
        // base case
        ArrayList<Integer> list = new ArrayList<Integer>();
        if (root == null) {
            return list;
        }
        // divide
        ArrayList<Integer> left = preorderTraversal(root.left);
        ArrayList<Integer> right = preorderTraversal(root.right);
        // conquer
        list.add(root.val);
        list.addAll(left);
        list.addAll(right);
        return list;
    }
}

```

## Version 2 (Traverse)

```java
public class Solution {
    /**
     * @param root: The root of binary tree.
     * @return: Preorder in ArrayList which contains node values.
     */
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
}

```

The code below can be easily changed to implement inorder-traversal and postorder-traversal


### Pre-oder traversal
```java
        // pre-oder traversal
        list.add(root.val);
        getValue(root.left, list);
        getValue(root.right, list);
        return;
```

### In-oder traversal
```java
        // in-oder traversal
        getValue(root.left, list);
        list.add(root.val);
        getValue(root.right, list);
        return;
```

### Post-oder traversal
```java
        // post-oder traversal
        getValue(root.left, list);
        getValue(root.right, list);
        list.add(root.val);
        return;
```


# Description: 


# Thought Process:

My first version intented to use divide and conquer algorithm to collect all the data through preorder-traversal. However, even I correctly implemented the **divide section**, my conquer section is actually not doing the right thing.  

According to divide and conquer algorithm, the program should divide a problem into different section (left, right subtree) and **gradually** collect and **combine** those reulst/data into the **final** result. Even I correctly implemented the divide algorithm, however, my conquer section simply adding data **one at a time** to the arrayList.  

Since the ArrayList we created at the begining of the `main` passed as a reference to the rest of the recursive call, we do not need to return the **whole list** to the previous function call since we are able to directly mannipulat the arrayList without passing the whole arrayList.  

## Verison 0 (Passed):

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
     * @return: Preorder in ArrayList which contains node values.
     */
    public ArrayList<Integer> preorderTraversal(TreeNode root) {
        // write your code here
        ArrayList<Integer> list = new ArrayList<Integer>();
        // base case
        if (root == null) {
            return list;
        }
        list.add(root.val);
        // divide
        list = getValue(root.left, list); //left
        list = getValue(root.right, list); //right
        // conquer
        return list;
    }
    private ArrayList<Integer> getValue(TreeNode root, ArrayList<Integer> list) {
        // base case
        if (root == null) {
            return list;
        }
        list.add(root.val);
        list = getValue(root.left, list);
        list = getValue(root.right, list);
        return list;
    }
}

```


# Corner Case:


# Reference: 

[Solution by Jiuzhang](http://www.jiuzhang.com/solutions/binary-tree-preorder-traversal/)  
[Recursion advantage vs disadvantage](http://stackoverflow.com/questions/5250733/what-are-the-advantages-and-disadvantages-of-recursion)