title: "reverse-linked-list"
date: 2016-03-02 02:04:12
updated: 2016-03-02 02:04:12
tags: linkedlist
categories: leetcode
---


# #206 Reverse Linked List
[Try it yourself](https://leetcode.com/problems/reverse-linked-list/)


## Requirment:
Reverse a singly linked list.


## Solution 1: (Iteratively O(N))

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseList(ListNode head) {
        if (head == null) {
            return null;
        }
        
        ListNode curr = new ListNode(0);
        ListNode tmp = new ListNode(0);
        ListNode reverseHead = new ListNode(0);
        // create the head for reversed list.
        curr = head;
        tmp.val = curr.val;
        tmp.next = null;
        reverseHead = tmp;
        
        while (curr.next != null) {
            curr = curr.next;
            tmp = new ListNode(0);
            tmp.val = curr.val;
            tmp.next = reverseHead;
            reverseHead = tmp;
        }
        return reverseHead;
    }
}
```

## Solution 2: (Cleaner Version)

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
 
// Much cleaner version with only manipulation on pointer 
public class Solution {
    public ListNode reverseList(ListNode head) {
        ListNode pre = null;
        while (head != null) {
           ListNode temp = null;
           temp = head.next;
           head.next = pre;
           pre = head;
           head = temp;
        }
        return pre;
    }
}
```


# #92. Reverse Linked List II

[Try it yourself!](https://leetcode.com/problems/reverse-linked-list-ii/)

## Task:

Reverse a linked list from position `m` to `n`. Do it in-place and in one-pass.

For example:
Given `1->2->3->4->5->NULL`, `m = 2` and `n = 4`,

return `1->4->3->2->5->NULL`.

Note:
Given `m`, `n` satisfy the following condition:
`1 ≤ m ≤ n ≤ length of list`.

### Note
This version can also be implied to other similar question on the interview:  
Example: To reverse the second half of the linkedlist. 


## Solution:
```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseBetween(ListNode head, int m, int n) {
        // corner case, 1. empty, 2, single element, 3, m < n constraint, 4. duplicate, 
        if (head == null || m > n || m == n) {
            return head;
        }
        // create dummy header to get back to orginal linkedlist
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        head = dummy; 
        
        // treverse to head. 
        for (int i = 1; i < m; i++) {
            // index outof bound
            if (head.next == null) {
                return null;
            }
            head = head.next;
        }
        // safe back ptr and proceed head
        ListNode backPtr = head;
        head = head.next;
        // m = n
        ListNode subPre = null;
        for (int j = 0; j < (n - m) + 1; j++) {
            ListNode temp = head.next;
            head.next = subPre;
            subPre = head;
            head = temp;
        }
        
        // reconnect the linked list.
        backPtr.next.next = head;
        backPtr.next = subPre;
        return dummy.next;
    }
}

```


# Reference:
[reverse linked-list](http://www.jiuzhang.com/solutions/reverse-linked-list/)  
[reverse linked-list 2](http://www.jiuzhang.com/solutions/reverse-linked-list-ii/)
