title: "Java Interface"
date: 2016-07-18 17:54:44
tags:
- Java
- Polymorphism
---

# Introduction

Lets look at following code: 

```Java
List list = new ArrayList(); 
```

The code above creates a reference of `List` type with variable called `list`, which is implemented by an internal `ArrayList` data structure.  

To better understand the benefits of writing code above, I would like to first introduce few key words below: Polymorphism, Dynamic-linking, and upper casting vs lower casting.  

# Java: Polymorphism

Polymorphism is one of the three important concepts in Java Programing language. The three essential concepts are: encapsulation, polymorphism and inheritance. We will discuss encapsulation and inheritance at a later time.  

[父类引用指向子类对象](http://blog.csdn.net/gideal_wang/article/details/4913965)

多态性  

父类引用指向子类对象指的是：

例如父类Animal，子类Cat,Dog。其中Animal可以是类也可以是**接口**，Cat和Dog是继承或**实现**Animal的子类。

java中一种多态的形式，接口类型的引用指向了实现接口类型的对象。

和其中的

动态链接，

向上转型：

## Benefit of Polymorphism: 
- 使用所有父亲有的方法(methods)


# Polymorphism: 父类引用指向子类对象

2、[不能]把父类对象引用赋给子类对象引用变量 

BaseClass a2=new BaseClass(); 
DerivedC c1=a2;//出错 

在java里面，向上转型是自动进行的,但是向下转型却不是，需要我们自己定义强制进行。 
c1=(DerivedC)a2; 进行强制转化,也就是向下转型. 

# Polymorphism: 动态链接

# Polymorphism: 向上/向下转型

[强制类型转换去调用(ArrayList)list.clone()](http://www.iteye.com/problems/96789)

# Polymorphism: Summary

   对于多态，可以总结以下几点：

    一、使用父类类型的引用指向子类的对象； 
    二、该引用只能调用父类中定义的方法和变量； 
    三、如果子类中重写(Overriding)了父类中的一个方法，那么在调用这个方法的时候，将会调用子类中的这个方法；（动态连接、动态调用） 
    四、变量不能被重写（覆盖），”重写“的概念只针对方法，如果在子类中”重写“了父类中的变量，那么在编译时会报错。 
    五、如果子类中重载(Overloading)了父类中的一个方法，那么在父类的引用[无法]调用这个子类的重载方法。

# Interface - Analysis: 


List - Interface, ArrayList implements the List interface.   

# Interface - Flexibility

```Java
List list = new ArrayList(); 
```

is more flexible than 

```Java
ArrayList list = new ArrayList(); 
```

Here is an detail example:  

```java

public List<Integer> preorderTraversal(TreeNode root) {
	List<Integer> list = new ArrayList<Integer>();
	// algorithm for preorderTraversal
	....
	return list;
}

```

The code above creates a data that is type of `List` and with underlining data structure as `ArrayList`.

For some reason, we later decide to switch the internal data strucutre from `ArrayList` to some other data structures that implements the `List` interface, `LinkedList` for example. We can easily switch to `LinkedList` by following changes: 

```java

public List<Integer> preorderTraversal(TreeNode root) {
	List<Integer> list = new LinkedList<Integer>();
	// algorithm for preorderTraversal
	....
	return list;
}

```

And everything will remain unchange. What will happen if we did not use the Interface at the begining?  

```java

public ArrayList<Integer> preorderTraversal(TreeNode root) {
	ArrayList<Integer> list = new ArrayList<Integer>();
	// algorithm for preorderTraversal
	....
	return list;
}

```
**1.Change return type**   

`ArrayList<Integer>` to `LinkedList<Integer>`  

**2.Change the declaration**  

`ArrayList<Integer> list = new ArrayList<Integer>();`   
to   
`LinkedList<Integer> list = new LinkedList<Integer>();`  

**3.Change to upper level code that call perorderTraversal() method**  

Since the return type of method `perorderTraversal()` changed to `LinkedList<Integer>` now, any upper level code that depends on `perorderTraversal()` method should be modified to adapt the new return data type. And this will not be acceptable.  

Code without using the interface `List` is much less flexible than the one with interface.  

> ...it will allow you to make implementation-specific changes later without breaking existing code ([StackOverflow](http://stackoverflow.com/questions/9852831/polymorphism-why-use-list-list-new-arraylist-instead-of-arraylist-list-n)).

It will be helpful, if possible, to `new` something, use `Interface` on the left side to maximize the flexibility of the program.  

# Interface - Analogy

One of the analogy I really like was introduced by the following website in Chinese [[面向接口编程详解（一）——思想基础](http://www.cnblogs.com/leoo2sk/archive/2008/04/10/1146447.html)]  

The artical uses the following analogy to help us better understand the idea of interface.  

Imagine your laptop's is excited about getting a new harddisk, which has a larger capacity and a faster speed, and maybe an even larger caches. You will imagine that switching from a 60GB hardisk to a 500GB one will not break normal function of the computer, which should be true in general.  

The reason behind this is the interface (`SATA`) provide to conenct differnt type of hard-disk is identical. Switching from 60GB to 500GB (`ArrayList` to `LinkedList`) should not break the normal functionality of the machine (program).  

That analogy really helps to better explain the underline idea of interface in a more interesting way.  


# Reference: 

[StackOverflow](http://stackoverflow.com/questions/9852831/polymorphism-why-use-list-list-new-arraylist-instead-of-arraylist-list-n)  
[详细说明 List list = new ArrayList()](http://blog.csdn.net/bobge/article/details/3298728)  
[面向接口编程详解（一）——思想基础](http://www.cnblogs.com/leoo2sk/archive/2008/04/10/1146447.html)  
[父类引用指向子类对象](http://blog.csdn.net/gideal_wang/article/details/4913965)
