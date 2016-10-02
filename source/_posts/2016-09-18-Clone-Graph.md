title: "Clone Graph"
date: 2016-09-18 19:21:37
tags:
- LintCode
- Graph
- DFS
- BFS
---

[Clone Graph](http://www.lintcode.com/en/problem/clone-graph/#)

# Code: 

# BFS approach

```java
/**
 * Definition for undirected graph.
 * class UndirectedGraphNode {
 *     int label;
 *     ArrayList<UndirectedGraphNode> neighbors;
 *     UndirectedGraphNode(int x) { label = x; neighbors = new ArrayList<UndirectedGraphNode>(); }
 * };
 */
public class Solution {
    /**
     * @param node: A undirected graph node
     * @return: A undirected graph node
     */
    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        // write your code here
        if (node  == null) {
            return null;
        }
        Queue<UndirectedGraphNode> queue = new LinkedList<UndirectedGraphNode>();
        HashMap<UndirectedGraphNode, UndirectedGraphNode> map = new HashMap<UndirectedGraphNode, UndirectedGraphNode>();
        queue.offer(node);
        map.put(node, new UndirectedGraphNode(node.label));
        
        while (queue.peek() != null) {
            UndirectedGraphNode curr = queue.poll();
            //UndirectedGraphNode currCopy = new UndirectedGraphNode(curr.label);
            UndirectedGraphNode currCopy = map.get(curr); // mapping ready exist, should not create new version of deep copy. 
            for (UndirectedGraphNode n : curr.neighbors) {
                if (!map.containsKey(n)) {
                    map.put(n, new UndirectedGraphNode(n.label));
                    currCopy.neighbors.add(map.get(n));
                    queue.offer(n);
                } else {
                    currCopy.neighbors.add(map.get(n));
                }
            }
        }
        return map.get(node);
    }
}
```


# DFS approach
```java
public class Solution {
    /**
     * @param node: A undirected graph node
     * @return: A undirected graph node
     */
    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        // write your code here
        if (node  == null) {
            return null;
        }
        return dfs(node, new HashMap<UndirectedGraphNode, UndirectedGraphNode>());
    }
    private UndirectedGraphNode dfs(UndirectedGraphNode node, HashMap<UndirectedGraphNode, UndirectedGraphNode> map) {
        if (map.containsKey(node)) {
            return map.get(node);
        }
        
        UndirectedGraphNode nodeCopy = new UndirectedGraphNode(node.label);
        map.put(node, nodeCopy);
        
        for (UndirectedGraphNode n : node.neighbors) {
            nodeCopy.neighbors.add(dfs(n, map));
        }
        return nodeCopy;
    }
}
```

<!--more-->

# Description: 

Clone an undirected graph. Each node in the graph contains a `label` and a list of its `neighbors`.  

How we serialize an undirected graph:  

Nodes are labeled uniquely.  

We use `#` as a separator for each node, and `,` as a separator for node label and each neighbor of the node.  

As an example, consider the serialized graph `{0,1,2#1,2#2,2}`.  

The graph has a total of three nodes, and therefore contains three parts as separated by `#`.  

First node is labeled as `0`. Connect node `0` to both nodes `1` and `2`.
Second node is labeled as `1`. Connect node `1` to node `2`.  
Third node is labeled as `2`. Connect node `2` to node `2` (itself), thus forming a self-cycle.  
Visually, the graph looks like the following:  

```
   1
  / \
 /   \
0 --- 2
     / \
     \_/
```
**Example**  
return a deep copied graph.

# Thought Process:

## BFS approach
- HashMap stores `<node, nodeDeepCopy>` pairs. Used to check if current node **already** has a deep copy.   
- HashMap also serves as a mean to retrive deep copy easily.  
- Queue stores child node's visiting order in same height. (level-order)  

> Note:   
> BFS = hashMap(visited nodes) + queue(FIFO, level-order-traversal)  
> no recursion required

## DFS approach
- Recursively performing DFS on current node's successor list (`neighbors`).  
- HashMap stores `<node, nodeDeepCopy>` pairs. Used to check if current node **already** has a deep copy.  
- HashMap also serves as a mean to retrive deep copy easily.  
- If already created a deep copy, simply returns the deep copy of the `UndirectedGraphNode`.  

> Note:   
> DFS = hashMap(visited nodes)  
> require recursion, like tree traersal

# Corner Case:

# Mistake made
- mistakenly hard code the path as to the diagram in example(DFS)
- forget to consider about node already `new` should not create again.(DFS)  
- in line 26, already created deep copy of node should just get from map.  

# Summary on DFS vs BFS

首先感觉这个问题问的好大。
我就稍微说几句，BFS 和 DFS 都是搜索算法，我就比较一下他们的优缺点。  
1**.BFS是用来搜索最短径路的解是比较合适的，比如求最少步数的解，最少交换次数的解.**  
因为BFS搜索过程中遇到的解一定是离根最近的，所以遇到一个解，一定就是最优解，此时搜索算法可以终止。这个时候不适宜使用DFS，因为DFS搜索到的解不一定是离根最近的，只有全局搜索完毕，才能从所有解中找出离根的最近的解。（当然这个DFS的不足，可以使用迭代加深搜索ID-DFS去弥补）

2**.空间优劣上，DFS是有优势的.**  
DFS不需要保存搜索过程中的状态，而BFS在搜索过程中需要**保存搜索过的状态(no queue required)**，而且一般情况需要一个队列来记录。

3.**DFS适合搜索全部的解**.  
因为要搜索全部的解，那么BFS搜索过程中，遇到离根最近的解，并没有什么用，也必须遍历完整棵搜索树，DFS搜索也会搜索全部，**但是相比DFS不用记录过多信息**，所以搜素全部解的问题，DFS显然更加合适。

上面提到的迭代加深搜索（ID-dfs）我觉得充分吸收了BFS和DFS各自的长处 (限制dfs的深度来迭代加深搜索)

# Reference: 

[LeetCode: Clone Graph 解题报告](http://www.cnblogs.com/yuzhangcmu/p/4044271.html)  
[LinkedList vs PriorityQueue for Queue Java](http://www.kancloud.cn/kancloud/data-structure-and-algorithm-notes/72904)  
[理解深度优先搜索（DFS）和广度优先搜索（BFS）](http://ju.outofmemory.cn/entry/193794)