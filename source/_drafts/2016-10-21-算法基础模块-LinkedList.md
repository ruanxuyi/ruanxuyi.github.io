title: "算法基础模块:LinkedList"
date: 2016-10-21 16:45:10
tags:
- Java
- LinkedList
- 算法基础模块
---


## Reverse a Linked list

```java
	public static ListNode reverse (ListNode head) {
		if (head == null) {
			return head;
		}
		ListNode pre;
		ListNode curr;
		ListNode tmp;
		
		pre = head;
		curr = head.next;
		
		while (curr != null) {
			tmp = curr.next;
			curr.next = pre;
			pre = curr;
			curr = tmp;
		}
		
		head.next = null; // current tail to null
		return pre; // new head @pre
	}
```

## Delete/add node

## Merge Multiple Linked List

## Deep copy

## Find middle of linked list (slow-fast pointers)

