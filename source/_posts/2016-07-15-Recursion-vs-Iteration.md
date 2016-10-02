title: "Recursion vs Iteration"
date: 2016-07-15 12:59:42
tags:
- Algorithm
- Recursion
---

![](https://i.ytimg.com/vi/Px8dgjKeh5I/maxresdefault.jpg)

<!--more-->

# Introduction

Most of the problems can be expressed as either recursion or iteration method. 

> Q: Is the recursive version usually faster?   
A: No -- it's usually slower (due to the overhead of maintaining the stack)

> Q: Does the recursive version usually use less memory?  
A: No -- it usually uses more memory (for the stack).


# Then why use recursion?    
Sometimes it is much **simpler** to write the recursive version, especially for following examples:  
- factorial  
- fibonacci  
- trees-traversal  


## Recursion vs Iteration: Factorial

Example: $$3!=3\times 2\times 1$$
$$0! = 1$$
$$-1! = undefined$$

The first definition leads to an **iterative** version of factorial:


```java
int factorial (int N) {
  // base case
  if (N == 0) return 1;
  int tmp = N;
  for (int k=N-1; k>=1; k--) tmp = tmp*k;
  return (tmp);
}
```

The second definition leads to a **recursive** version:

```java
int factorial (int N) {
  // base case
  if (N == 0) return 1;
  else return (N*factorial(N-1));
}
```


The recursive version is
a little shorter,  
a little clearer (closer to the mathematical definition),  
a little slower  

## Recursion vs Iteration : Fibonacci

Example:  
$$Fib(1) = 1 ,  Fib(2) = 1$$
$$Fib(4) = Fib(3) + Fib(2) = (Fib(1) + Fib(2)) + Fib(2) = 1 + 1 + 1 = 3$$

**Iterative version:** 

```java 

// iterative version
int fib (int N) {
  int k1, k2, k3;
  k1 = k2 = k3 = 1;
  for (int j = 3; j <= N; j++) {
      k3 = k1 + k2;
      k1 = k2;
      k2 = k3;
  }
  return k3;
}

```

**Recursive version:** 

```java

// recursive version
int fib (int N) {
  if ((N == 1) || (N == 2)) return 1;
  else return (fib (N-1) + fib (N-2));
}

```


For fibonacci, the recursive version is:  
- shorter,  
- clearer,  
- but **much** slower  

The reasoning behind the fact that recursive is musch slower is not only the overhead in the activation record (locates in working memory), but also because of the **repeated computation** in the recursive algorithm.  

![](http://pages.cs.wisc.edu/~vernon/cs367/notes/RECURSION-FIGURES/Image11.gif)

Noted that, `Fib(3)` has repeated 3 times, and `Fib(4)` has repeated 2 times. We can stores the calculated values and avoid the repeat computation and likely speed up the fibonacci with recursive algorithm.  


# Why Recursion Slow?

**Why recursive code is running slow?**

Every time the function is calling itself, **input parameters, local variables, return address. etc.**, have to be stroed in user stack for the return process for the final solution. This type of storing pushing into stack process is very time comsuming therefore very deep recursive call will hurt run time performance of the program.  

# Tail Recursion Intro.

In a simple word, tail recursion is a type of recursion that can run **faster** compare to regular Recursion. The reasoning behind this is tail recursion **eliminate** the final return steps, which propogates through all the level of recursion for the final solution. However, the downside of tail recurion is its requirement of space for storing extra parameters.  

Detail example please refer to the link below: 

[递归为什么那么慢？递归的改进算法](http://blog.sina.com.cn/s/blog_77dd9d490102vwgr.html)  

# Summary

- Use recursion for **clarity**, and (sometimes) for a reduction in the time needed to write and debug code, not for space savings or speed of execution.  

- Remember that every recursive method must have a **base case**(rule #1).  
- Also remember that every recursive method must **make progress towards** its **base case** (rule #2).  
- Sometimes a recursive method has more to do following a recursive call. It gets done only after the recursive call (and all calls it makes) finishes.  
- Recursion is often **simple and elegant**, can be efficient, and tends to be underutilized. Consider using recursion when solving a problem!  


# Reference
[Cover image by ytimg.com](https://i.ytimg.com/vi/Px8dgjKeh5I/maxresdefault.jpg)  
[UW-Madison CS367](http://pages.cs.wisc.edu/~vernon/cs367/notes/6.RECURSION.html#iter)  
[递归为什么那么慢？递归的改进算法](http://blog.sina.com.cn/s/blog_77dd9d490102vwgr.html)  


