string = either `pointer to char (char *)` OR `char array array[]`

```c
char a[] = "string literal";
char *p  = "string literal";

```

Since `char *a == char a[]` -> `char **argv == char *argv[]`


## `char a[] = "string literal";`  
- C string is char array  
- created as read only string  
- stores original read-only string into stack, since it is in stack, we **can** use the pointer to modify the content.

```c
char *string = "CONSTANT string";
printf("%c\n", string[1]);//prints O
string[1] = 'o';//INVALID!!
```


## `char *p  = "string literal";`  
- array is created in a **read-only** part of memory, array **cannot** be modified.  
- pointer to the **first** element of the static array of chars  

```c
char *string = "CONSTANT string";
printf("%c\n", string[1]);//prints O
string[1] = 'o';//INVALID!!
```

## is `char string[] = {"aaa", "bbb"}; valid?`
- left side is type `char array`, 
- right side type `an array of char pointers(char array)`.  

**Fixes:** `char* string[] = {"aaa", "bbb"};` // array of pointers to CONSTANT string  

- **read as:** an array of char pointers.  
- `char*` : char pointer, stores in read-only memory.(actual content of `"aaa"`, or `"bbb"` cannot be modified).  

Since both `"aaa"` and `"bbb"` are pointed by `char*`, `"aaa"` and `"bbb"` locate at *read-only* memory.  

For example: the change of the second elemnt in array from `"bbb"` into `"bab"` is **NOT** vaild.  

```c
	char* string[] = {"aaa", "bbb"};
    string[1][1] = 'a'; // read-only memory

```

However, the folloowing operation is still vaild.  

```c
    char* string[] = {"aaa", "bbb"};
    string[1] = "ccc"; // static char array stores in read-only mem
    //printf("%c\n", string[0]);
    printf("%s\n", string[1]);
```
Even `"aaa"` and `"bbb"` locate at *read-only* memory. `string[1] = "ccc"` modifies the content of the *array* (`string[]`), which is located at the *stack* (writable). 


> **Note:**   
Since `char *a == char a[]` -> `char **argv == char *argv[]` reads an array of char pointers.


## Array in C

```c
int array[] = { 45, 67, 89 };
```

Decaying is an implicit &; `array == &array[0]`. In English, these expressions read “array”, “pointer to the first element of array” (the subscript operator, [], has higher precedence than the address-of operator). But in C, all three expressions mean the same thing.  

```c
    int a = 1, b = 2, c = 3;
    int array[] = {a, b, c};
    printf("%d, %d, %d\n", array[0], array[1], array[2]);
```

The code below has the same result above, but the `array` variable now is an array of `int pointers`. 

```c
    int a = 1, b = 2, c = 3;
    //int array[] = {a, b, c};
    int *a_ptr = &a;
    int *b_ptr = &b;
    int *c_ptr = &c;
    int *array[3] = {a_ptr, b_ptr, c_ptr};
    printf("%d, %d, %d\n", *array[0], *array[1], *array[2]);
```

Benefit from the decaying feature in C, `array`, a pointer to the first elemnt in array. We have:  

```c
    printf("%d, %d, %d\n", *(*array), (*array[0]));

```
`(*array)` - give us the `int *` for the first element, therefore `(*(*array))` will give us the value of the `a_ptr` which is `a = 1`

If:  

(They would not all mean the same thing if “array” were actually a pointer variable (ex. `int *array_ptr = array;`), since the address of a **pointer variable** is different from the address inside it—thus, the middle expression, &array, would not be equal to the other two expressions. The three expressions are all equal only when array really is an array.)


**Note:**

> You cannot set a list of values **after** the initialization of the array. The initialization of array below is NOT valid. 

```c
int myArray[SIZE];
myArray = {1,2,3,4....};
```

Instead, you should assign the list of values while creating the array.  

```
int myArray[SIZE] = {1,2,3,4....};
```


## Pointer Arithmetic (why 1== 4?)

```c
int array[] = { 45, 67, 89 };
int *array_ptr = array;
printf(" first element: %i\n", *(array_ptr++));
printf("second element: %i\n", *(array_ptr++));
printf(" third element: %i\n", *array_ptr);
```

Console out: 

```
first element: 45
second element: 67
third element: 89
```

- `array_ptr` type `int` -> `array_ptr + 1` = `array_ptr` + `1 * sizeof(int)`
- in general: type `*ptr`, `ptr+=const = ptr + const * sizeof(type)`  

**Note:** 
> The `printf` statament above evaluate `arry_ptr` *before* it gets increment.  

## Indexing of Array

`array[0]` in Java will return the value of the first element in the array. However, it works little different in C programing even `array[0]` return the same result.  

In C programing, the meaning of `array[1]` is following:  
- `array` is a pointer, it points to the address of first element  
- `array[1] = *(array + 1)`  
- `array + 1` = `array + sizeof(int) * 1`


## array =?= &array

```c
int array[] = { 45, 67, 89 };
int *array_ptr = array;
printf("%p, %p\n", array, &array);
```

For code above, even though the **values** of `array` and `&array` are the same(decaying feature from C), the **type** of those two are not the same.  

`array` - `'int *'` [pointer to type `int`]  
`array_ptr = &array` - `'int (*)[3]'` [pointer to type `int[3]`]

The difference above is when you increment `array`, it will point to the next element in the array (`array + sizeof(int) * 1`).  

However, when you increment `array_ptr`, it will add the size of the **entire array**.

## Structures and unions 



## set pointer to NULL after `free()`


if you free() the block but don't "forget" your pointer, you may accidentally try to access data through that pointer in the future OR someone else might able to have chance to access/overwrite your old/new data.  

> the best practice for this is to set the pointer to NULL after freeing the memory, because you can easily test for NULL, and attempting to access memory via a NULL pointer will cause a bad but consistent behaviour, which is much easier to debug.

[How do free and malloc work in C?](http://stackoverflow.com/questions/1957099/how-do-free-and-malloc-work-in-c)  


# Reference: 

[All you need to know about C](http://boredzo.org/pointers/) 
[char* string[] explanation](http://stackoverflow.com/questions/20347170/char-array-and-char-array)  
[Array initialzaiton with list of values](http://stackoverflow.com/questions/3137671/declaring-and-initializing-arrays-in-c)  
[array vs &array](http://stackoverflow.com/questions/2528318/how-come-an-arrays-address-is-equal-to-its-value-in-c)  
[size_t的用法](http://wangyi201212aaa.blog.163.com/blog/static/234999127201432492014746/)  
[Boolean printf in C](http://stackoverflow.com/questions/17307275/what-is-the-printf-format-specifier-for-bool)  
[pointer-to-pointer-with-argv](http://stackoverflow.com/questions/7631282/pointer-to-pointer-with-argv)  


