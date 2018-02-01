title: "LC128 - hash function"
date: 2017-01-07 14:13:47
tags:
- LintCode
- HashTable
- DataStructure
---

## <center> description </center>
In data structure Hash, hash function is used to convert a string(or any other type) into an integer smaller than hash size and bigger or equal to zero. The objective of designing a hash function is to "hash" the key as unreasonable as possible. A good hash function can avoid collision as less as possible. A widely used hash function algorithm is using a magic number 33, consider any string as a 33 based big integer like follow:

```
hashcode("abcd") = (ascii(a) * 333 + ascii(b) * 332 + ascii(c) *33 + ascii(d)) % HASH_SIZE 
                             = (97* 333 + 98 * 332 + 99 * 33 +100) % HASH_SIZE
                             = 3595978 % HASH_SIZE
```
here `HASH_SIZE` is the capacity of the hash table (you can assume a hash table is like an array with index 0 ~ `HASH_SIZE`-1).

Given a string as a key and the size of hash table, return the hash value of this key.f

**Clarification**
For this problem, you are not necessary to design your own hash algorithm or consider any collision issue, you just need to implement the algorithm as described.

**Example**
For `key="abcd"` and `size=100`, return `78`

[LC129 hash function](http://www.lintcode.com/en/problem/hash-function/)

## <center> code </center>

### Ver.1 
```java
import java.math.*;

class Solution {
    /**
     * @param key: A String you should hash
     * @param HASH_SIZE: An integer
     * @return an integer
     */
    public int hashCode(char[] key,int HASH_SIZE) {
        // write your code here
        long sum = 0;
        int len = key.length;
        for (int index = 0; index < len; index++) {
            sum = (sum * 33 + (int)key[index]) % HASH_SIZE;  //(int)'a' returns asiic of 'a'
        }
        return (int)sum;
    }
};
```

<!--more-->

### Time out ver.2
```java
import java.math.*;

class Solution {
    /**
     * @param key: A String you should hash
     * @param HASH_SIZE: An integer
     * @return an integer
     */
    public int hashCode(char[] key,int HASH_SIZE) {
        // write your code here
        BigInteger sum = BigInteger.valueOf(0);
        int len = key.length;
        for (int index = 0; index < len; index++) {
            char curr = key[index];
            BigInteger base = BigInteger.valueOf(33);
            sum = sum.add(BigInteger.valueOf((int)(curr)).multiply(base.pow(len-index-1)));
        }
        return (sum.mod(BigInteger.valueOf(HASH_SIZE))).intValue();
    }
};
```

## <center> algorithm correctness </center>

There are two versions of implementation. The second version did **not** pass the test. The first version is **better** than second version in following:  

- using `long` instead of `BigInteger`:   

`long` type support direct arithmetic opeartion, which `BigInteger` did not support.  

- mod `HASH_SIZE` at every iteration to prevent `sum` overflow:  

Instead of mod a huge `sum` w/ potential of **overflow**, we mod the HASH_SIZE with current `sum` at every iteration to prevent overflow.   

### mod property to prevent overflow
Below we prove that taking [mod of sum] **equals** to [sum of mod of partial sum]

$(7+6) \mod 5 == ((7\mod5) + 6)\mod5$   
Left:   
$(7+6) \mod 5 = 13\mod5 = 3$  
Right:  
$((7\mod5) + 6)\mod5 = 8\mod5 = 3$

Therfore:   
$left == right$  

Mod `HASH_SIZE` at every iteration significant eliminate chance of overflow.

### alteration for Math.pow()

Instead of using `Math.pow()` explicitly write out every terms for base 33 **power**.  

![](http://7xihzu.com1.z0.glb.clouddn.com/20170107/1.png)
We modify it to more structurized code:  

```java
        for (int index = 0; index < len; index++) {
            sum = (sum * 33 + (int)key[index]) % HASH_SIZE;
        }
```

we also need to show that the for-loop from `line 13-15` in version 1 has the same result as the `hashcode()` function

![](http://7xihzu.com1.z0.glb.clouddn.com/20170107/2.png)


## <center> complexity analysis </center>

Both algorithm result in same complexity where $n$ is length of `key`.  

Time: $O(n)$  
Space: $O(1)$

## <center> self notes </center>
## <center> application </center>

## <center> reference </center>
[hash function sol](http://www.jiuzhang.com/solutions/hash-function/)  
[hash function overflow](http://www.jiuzhang.com/qa/1978/)
