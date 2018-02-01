title: "LC174 - Remove Nth Node From End of List"
date: 2016-10-16 17:38:00
tags:
- LintCode
- TwoPtrs
- LinkedList
---

Try it here:  
[LC174:Remove Nth Node From End of List](http://www.lintcode.com/en/problem/remove-nth-node-from-end-of-list/)
# <center> Code: </center>

## V0
```java
public class Solution {
    /**
     * @param head: The first node of linked list.
     * @param n: An integer.
     * @return: The head of linked list.
     */
    ListNode removeNthFromEnd(ListNode head, int n) {
        // write your code here
        if (head == null || n < 0) {
            return null;
        }
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        
        ListNode curr = dummy;
        for (int i = 0; i < n; i++) {
            head = head.next;
        }
        while (head != null) {
            curr = curr.next;
            head = head.next;
        }
        curr.next = curr.next.next;
        return dummy.next;
    }
}
```
<!--more-->

## V1
```java
/**
 * Definition for ListNode.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int val) {
 *         this.val = val;
 *         this.next = null;
 *     }
 * }
 */ 
public class Solution {
    /**
     * @param head: The first node of linked list.
     * @param n: An integer.
     * @return: The head of linked list.
     */
    ListNode removeNthFromEnd(ListNode head, int n) {
        // write your code here
        if (head == null) {
            return head;
        }
        int length = 0;
        int target = 0;
        ListNode curr = head;
        ListNode temp;
        // get length of linked list
        while (curr != null) {
            curr = curr.next;
            length++;
        }
        
        curr = head;
        target = length - n;
        
        // get to n's ancester
        while (target > 1) {
            curr = curr.next;
            target--;
        }
        // delete head
        if (target == 0) {
            temp = curr.next;
            curr.next = null;
            head = temp;
            return head;
        }
        // delete non head
        temp = curr.next.next;
        curr.next.next = null;
        curr.next = temp;
        
        return head;
    }
}
```


# <center> Description: </center>
Given a linked list, remove the nth node from the end of list and return its head.

**Notice**  
The minimum number of nodes in list is n.

**Example**  
Given linked list: `1->2->3->4->5->null`, and `n = 2`.

After removing the second node from the end, the linked list becomes `1->2->3->5->null`.

**Challenge**   
Delete op in single run for worst case?

# <center> Process: </center>
## V0:  
- keep **two pointers** `curr` and `head`  
- `head` counts `n` first, then `curr` follows.  
- `head` and `curr` proceed **simutaneously** until `curr` hit the end of the list.  
- exploit parallelism of two pointers   


[github]()

# <center> Reference: </center>
[Jiuzhang](http://www.lintcode.com/en/problem/remove-nth-node-from-end-of-list/)
