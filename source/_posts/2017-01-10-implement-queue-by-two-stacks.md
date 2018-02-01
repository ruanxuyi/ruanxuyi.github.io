title: "LC40 - implement queue by two stacks"
date: 2017-01-10 10:47:57
tags:
- LintCode
- Stack
- Queue
- DataStructure
---


## <center> description </center>

As the title described, you should only use two stacks to implement a queue's actions.

The queue should support `push(element)`, `pop()` and `top()` where pop is pop the first(a.k.a front) element in the queue.

Both pop and top methods should return the value of first element.

**Example**

```
push(1)
pop()     // return 1
push(2)
push(3)
top()     // return 2
pop()     // return 2
```

[LC40 implement queue by two stacks](http://www.lintcode.com/en/problem/implement-queue-by-two-stacks/)  

## <center> code </center>

```java
public class Queue {
    private Stack<Integer> stack1;
    private Stack<Integer> stack2;

    public Queue() {
       // do initialization if necessary
       stack1 = new Stack<Integer>();
       stack2 = new Stack<Integer>();
    }
    
    public void push(int element) {
        // write your code here
        while (!stack2.empty()) {
            stack1.push(stack2.pop());
        }
        stack1.push(element);
    }

    public int pop() {
        // write your code here
        while(!stack1.empty()) {
            stack2.push(stack1.pop());
        }
        return stack2.pop();
    }

    public int top() {
        // write your code here
        while(!stack1.empty()) {
            stack2.push(stack1.pop());
        }
        return !stack2.empty() ? stack2.peek() : -1;
    }
}
```

<!--more-->

## <center> algorithm correctness </center>
Stack is a last in first out(LIFO) datastructure. To implement Queue, which is first in first out (FIFO), with two stacks, we need to play some tricks.  

Asssume we have following operations: `push(1), push(2), push(3), pop()`

In Queue, `pop()` operation should return `1`. However, a single Stack only allow us to retrive `3` with `pop()` operation. Since we have two Stacks, we can use the first stack `stack1` as the **push stack**, and the other stack `stack2` as the **pop/top stack**. 

Here is the alagorithm:  
1. on `push()` add element to `stack1` if `stack2` is empty.  
2. on `pop()/top()`, pop all current elements from `stack1` and push them into `stack2` so that the **bottom element** of `stack1` (first original pushed) will appear in the **top** of the `stack2`.  

Example above looks like this:
  
```
push(1), push(2), push(3)

		stack1    stack2
		| 3 |     |   |
		| 2 |     |   |
		|_1_|     |___|

```
On `pop()`

```
pop() -> 1

		stack1    stack2
		|   |     | 1 |
		|   |     | 2 |
		|___|     |_3_|

```

if we continue to `push(4)`, then we **pop** out all elements from `stack2` to `stack1` first, then **push** the new element.

```
push(4)

		stack1    stack2          stack1
		| 3 |     |   |           | 4 |
		| 2 |     |   |     ->    | 3 |
		|_1_|     |___|           | 2 |
		                          |_1_|
```

## <center> complexity analysis </center>

**Time**: all operations are $O(1)$ on average.  


## <center> self notes </center>
## <center> application </center>
## <center> reference </center>
