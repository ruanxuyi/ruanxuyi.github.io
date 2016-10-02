title: "Intro to Algorithms Exercises"
date: 2016-08-30 09:18:23
tags:
- Algorithm
---


# Chapter 01

## Section 1

### 1.1.1
Give a real-world example that requires sorting or a real-world example that requires computing a convex hull.

### 1.1.2
Other than speed, what other measures of efficiency might one use in a real-world setting?

> Memory Usage, resource utilization (network/database) 

### 1.1.3
Select a data structure that you have seen previously, and discuss its strengths and limitations.> Array:  
> Pros: easy/fast access with index.  
> Cons: fix array size at initalization.  

### 1.1.4
How are the shortest-path and traveling-salesman problems given above similar? How are they different?> They are similiar in a way that both need to walk through a graph to find a path.   
> They are different in a way that shortest path find shortest path between two node. While traveling-salesman need to find the shortest path between more points that **return to** the starting point.  

### 1.1.5
Come up with a real-world problem in which only the best solution will do. Then come up with one in which a solution that is “approximately” the best is good enough.

> 1.sorting - quick sort  
> 2.shortest path between two points in a city, even it might not be the fastest way depends on traffic, etc. it get you there.


## Section 2: 

### 1.2.1
Give an example of an application that requires algorithmic content at the application level, and discuss the function of the algorithms involved.

> Uber/Lyft car on call service utilizes alogrithm in application level to find the best avaviable car around quickly.  

### 1.2.2
Suppose we are comparing implementations of insertion sort and merge sort on the same machine. For inputs of size n, insertion sort runs in $8n^2$ steps, while merge sort runs in $64n lg n$ steps. For which values of n does insertion sort beat merge sort?

![](graph.png)
> at $x>43$, merge sort beats insertion sort

### 1.2.3What is the smallest value of $n$ such that an algorithm whose running time is $100n^2$ runs faster than an algorithm whose running time is $2^n$ on the same machine?

> $[ 0 \leq n \leq 0.02]$

# Chapter 02
## Section 1:


### 2.1.2Rewrite the INSERTION-SORT procedure to sort into nonincreasing instead of non- decreasing order.

```java
		for (int i = 1; i < A.length; i++) {
			int currKey = A[i];
			int j = i - 1;
			while (j >= 0 && currKey > A[j]) {
				A[j+1] = A[j];
				j--;
			}
			A[j+1] = currKey;
		}	

```

### 2.1.3
Consider the searching problem:  Input: A sequence of n numbers $A = {a_1, a_2, a_3, \dots, a_n}$ and a value  $v$.  Output: An index $i$ such that $v = A[i]$ or the special value $NIL$ if does not appear in A.  Write pseudocode for linear search, which scans through the sequence, looking for  . Using a loop invariant, prove that your algorithm is correct. Make sure that your loop invariant fulfills the three necessary properties.

```java

for (int i = 0; i < A.length; i++) {
	if (A[i] == v) {
		return i;
	}
}
return null

```

### 2.1.4Consider the problem of adding two $n$-bit binary integers, stored in two $n$-element arrays $A$ and $B$. The sum of the two integers should be stored in binary form in an $(n+1)$-element array $C$. State the problem formally and write pseudocode for adding the two integers.

```java
	public static void main(String[] args) {
		int[] A = {0, 1, 1, 1, 1};
		int[] B = {1, 0, 1, 0, 1};
		int[] C = new int[A.length + 1];
		int sum, result, carry = 0;
		for (int i = A.length - 1; i > 0; i--) {
			sum = A[i] + B[i] + carry;
			if (sum == 3) {
				result = 1;
				carry = 1;
			} else if (sum == 2) {
				result = 0;
				carry = 1;
			} else if (sum == 1) {
				result = 1;
				carry = 0;
			} else {
				result = 0;
				carry = 0;
			}
			C[i+1] = result;
		}
		C[0] = carry;
	}
	
```

### 3.1.7

[Best CLRS 2e: Exercise 3.1-7](http://answers-by-me.blogspot.com/2010/07/clrs-2e-exercise-31-7.html)  


# Reference: 

[Introduction to Algorithms Exercise](http://clrs.skanev.com/index.html)  
[Solutions to Introduction to Algorithms](https://github.com/gzc/CLRS)