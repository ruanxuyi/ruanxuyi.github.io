## Memory has following three sections:  
- Text Segment
- Data  
- Stack


### Text/Code Segment 
- read only  


### Data Segement
- read-write  

#### Initialized Data
- static varibles (global variables, static local variables).  
- size of segment determines by size of values from source code.  
- the size of segment will not be changed at run time.  

#### Uninitialized Data
- store inside BSS segment


### Stack
- Stores l**ocal variables**, passed **parameters** into function, and **return values** from the function.  
- In multi-thread setting, different threads use different stacks (unique activation record). However, all the threads will share the heap.  
- Once function **complete** and return, any data on stack correspond to that function will **automatically** be **deleted**.  
- Extra memory can **NOT** be added to Stack if running out of space.  
- **Stack overflow** occurs when Stack is running out of space.  
- Stack overflow usually causes by too many function calls, infinte recursive call.  
- Allocate and deallocate memory on stack is simpler. Move stack pointer up and down (integer increment/decrement), which is faster compare to allocation in heap.  


### Operation of Stack
- stack usually **grows down** (toward the **lower** memory address, etc. intel)  
- **Stack Pointer(%esp)**: either point to the **last** address on stack OR **next** free available address address.  
- Stack pointer points to the **top** of the stack (**lowest** numerical address).  
- **Base Pointer** (**%ebp** for intel): points to a fix location within hte frame/activation record.  
- local variables have **negative** offsets from %ebp.  
- parameters have **positive** offsets from %ebp.  

**Create Object on Stack:**  
- create without key word `new`.  
- create inside a function  


```c++

void somefunction( )
{
/* create an object "m" of class Member
    this will be put on the stack since the 
    "new" keyword is not used, and we are 
   creating the object inside a function
*/
  
  Member m;

} //the object "m" is destroyed once the function ends


```

### Heap
- different threads share same heap space.  


**Create Object on Heap:**  
- create object with keyword `new`.  
- manually release allocated memory after finish using it. (ow. lead to memory leak).  
- Any datas on heap will reamin util maually deleted by programmers.(`free` in C, and `delete` in C++).    
- More memory **can be added** to heap by OS if heap is running out of space.   
- **Fragmentation** happens when total memory is enough for allocation, however, small chunk of current using segment is blocking in between the unused segement. That prevent OS to utilize the available space for allocation.  
- Allocate and deallocate memory in heap is more complicate than operations on Stack. It requires synchronization to be multi-thread safe.  

TODO: WHen use heap. when use stack??

```c++

void somefunction( )
{
/* create an object "m" of class Member
    this will be put on the heap since the 
    "new" keyword is used, and we are 
   creating the object inside a function
*/
  
  Member* m = new Member( ) ;
  
  /* the object "m" must be deleted
      otherwise a memory leak occurs
  */

  delete m; 
} 

```

