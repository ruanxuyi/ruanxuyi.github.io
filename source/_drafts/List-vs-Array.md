

# Abstract Data Types(ADTs)  
  
Abstract Data Type(ADT) provides easiness of use (public methods) for clients with cetrain level of abstraction (private implementation).  

The idea of an ADT has following two notions:  
**speficitaon(external - public)**  
- what type/kind of thing we are working on.  
- what operations/methods can be performed on it.  

**implementation(internal - private)**  
- the representation (how the structure is actually stored)  
- how operations/methods are actually implemented.  


### Benefits: 
- code is easy to understand (able to see high-level steps, while detailed implemetations are hidden).  
- Implemetations of ADT's methods can be changed without requiring changes to the program that uses the ADTs.  
- ADTs can be reused.  

ADT is a general idea in programming. In specified programming language, we can use different mechanism to implement the idea of the ADT. For example, object-oriented programming languages (like Java) make it easy for programmers to use ADT. 

ADT corresponds to a **java class** (or Java **interface**). And the operations on the ADT are the class/interface's **public methods**. For user/client of the ADTs, only informations about the opeartions (what does the method do, what is value of return type, input parameters, etc) needed to be provided. (NO detail implementations of the operation need to provide).  

In general, there are many possible operations that could be defined for each ADT; however, they often fall into these categories:  

- initialize  
- add data  
- access data  
- remove data  


# Java Interface
A mechanism for separating public interface from private implementation. `Java interface` is the mechanism that we use to implement ADT(Abstract Data Type) in Java language. 

List ADT (Java Interface) includes:   
- public method signatures  
- class constant  
- interface does not contain any method implementations  

List ADT 

```java
public interface ListADT<E> {
    void add(E item);
    void add(int pos, E item);
    boolean contains(E item);
    int size();
    boolean isEmpty();
    E get(int pos);
    E remove(int pos);
}
```


To implement an interface named InterfaceName, a Java class must do two things:
1. include "implements InterfaceName" after the name of the class at the beginning of the class's declaration, and  
2. for each **method signature** given in the interface InterfaceName, define a public method with the exact same signature


# List vs. Array

List (using its `size` **method**),   
Array (using its `length` **field**).

## Benefit of List
size of List can be dynamically modified while array has a fixed size. 

	int[] A = new int[10] // size 10 array
	
## Benefit of Array
- initiali size

following operation is allowed only on array.

	String[] strList = new String[10]; 
	strList[5] = "hello"; !

but this code will cause a runtime exception:

	ListADT<String> strList = new ArrayList<String>();
	strList.add(5, "hello"); // error! 

List with initial size= 0 can only add at position 0.

- data type

Array allows holding any data type incldues primitive type (eg. int, char).   

	int[] num = new int[10];

List allows only `Objects` unless with help of auto-boxing. Following will cause error: 

	List<int> num = new List<int>();
	
Error: 

	% javac Test.java
	Test.java:9: unexpected type
	found   : int
	required: reference
        List<int> numbers = new ArrayList<int>();

	


# Reference: 
[Introduction: Abstract Data Types](http://pages.cs.wisc.edu/%7Eskrentny/cs367-common/readings/Introduction/index.html)  
	
