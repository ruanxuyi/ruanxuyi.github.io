title: "LintCode 111 - Climbing Stairs"
date: 2016-08-16 11:12:48
tags:
- LintCode
- DP
- Recursive
- H
---

[Climbing Stairs](http://www.lintcode.com/en/problem/climbing-stairs/)

# Code: 

## Recursive V0 (time limited NOT passed)

```java

public class Solution {
    /**
     * @param n: An integer
     * @return: An integer
     */
    public int climbStairs(int n) {
        // write your code here
        if (n < 1) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }
        if (n == 2) {
            return 2;
        }
        return climbStairs(n - 1) + climbStairs(n - 2);
    }
}

```

## Iterative V1:  

```java

public class Solution {
    /**
     * @param n: An integer
     * @return: An integer
     */
    public int climbStairs(int n) {
        // write your code here
        if (n <= 1) {
            return 1;
        }
        int last = 1, lastlast = 1;
        int current = 0;
        for (int i = 2; i <= n; i++) {
            current = last + lastlast;
            lastlast = last;
            last = current;
        }
        return current;
    }
}

```


<!--more-->

# Description: 

You are climbing a stair case. It takes n steps to reach to the top.

Each time you can either climb `1` or `2` steps. In how many distinct ways can you climb to the top?


**Example**  
> Given an example `n=3` , `1+1+1=2+1=1+2=3`  
> return `3`  


# Thought Process:

If `n = 1`, we have `1` way to get to top.  
If `n = 2`, we hvae `1+1=2` ways to get to top.  
If `n = 3`, we have `1+2=3` ways to get to top.  
If `n = 4`, we have `2+3=5` ways to get to top.  
If `n = 5`, we have `3+5=8` ways to get to top...  

We can see above analysis is very similar to Fibonacci sequence. 

Instead of for Fibonacci sequence: 

$$Fib(1)=1,Fib(2)=1$$

We have: 

$$Fib(1)=1,Fib(2)=2$$

$$Fib(4)=Fib(3)+Fib(2)=(Fib(1)+Fib(2))+Fib(2)=2+2+1=5$$

Above can also be calculated by manually list out all possible **permutation** of `1's` and `2's`.  

# Corner Case:

NA

