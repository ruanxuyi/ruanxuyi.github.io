title: "Sorting Algorithms"
date: 2016-08-30 22:09:38
tags:
- Algorithm
- Sorting
---


# Quick Sort

![](http://7xihzu.com1.z0.glb.clouddn.com/quickSort.jpg)

## How to choose the piviot element? 

- why not choosing pivot randomly?

> randomly select pivot will work, however, the worst case time complexity of the algorithm will become $O(n^2)$.  

## Time Complexity Analysis

- **Worst case $O(n^2)$:**  
everytimes pivit picked is either the smallest or the largest elements of the array. From $n->n-1->n-2-> \dots -> 1$
- **Average/best case** $O(nlog(n))$:   
pivit split array evenly so the number of steps is less. From $n -> n/2->n/4 \dots$. Note: $O(nlog(n))$ is the height of the tree.  

## Algorithm
- select the middle value as the `pivot`.  
- maintain two pointers `left` and `right`.  
- `left` pointer traverse from left to right until found element **larger than** `pivot`.  
- `right` pointer traverse from right to left until found element **smaller than** `pivot`.  
- swap element at index `left` with `right`.  
- continue until `left` > `right`.  
- recursively `quickSort` the part **smaller** than `pivot` and the part **larger** than `pivot`.  

## Code Short Version

```java
public void quickSort(int[] array, int start, int end) {
	if (start >= end | start < 0 | end < 0) {
		return;
	}
	int left = start;
	int right = end;
	int pivot = array[end - (end - start)/2];
	while (left <= right) {
		while (array[left] < pivot) {
			left++;
		}
		while (pivot < array[right]) {
			right--;
		}
		if (left <= right) {
			int temp = array[right];
			array[right] = array[left];
			array[left] = temp;
			left++;
			right--;
		}
	}
	quickSort(array, start, right);
	quickSort(array, left, end);
}

```

## Algorithm
- similar process as the version above.  
- instead of randomly choosing `pivot` from the middle value.(which could possible be the largest/smallest, to lead to worst time performance [`quickSort` not able to break into even workload to utilize the parallelism.])   
- we choose following three values: `array[low]`, `array[mid]`, `array[high]`.  
- return the median of three as `pivot`.  
- re-value `array[0]` with `smallest`, `array[length - 1] = largest`, `array[mid] = array[length - 2]`, finally move `pivot` to `array[length - 2]`.  

## Code Faster Version

```java

public class QuickSort {
	public static void main(String[] args) {
		int[] A = {3, 4, 5, 9, 1, 2, 10, 6, -1, 8, 10, 9, 15, 23, 18, 0, 2};
		quickSort(A, 0, A.length - 1);
		for (int i = 0; i < A.length; i++) {
			System.out.print(A[i] + ", ");
		}
	}
	public static void quickSort(int[] array, int low, int high) {
		// pick pivot
		if (low < high) {
			int pivot = partion(array, low, high);
			quickSort(array, low, pivot);
			quickSort(array, pivot+2, high);
		}
	}
	public static int partion(int[] A, int low, int high) {
		int pivot = medianOfThree(A, low, high);
		int left = low + 1;
		int right = high - 2;
		// partition
		while (left <= right) {
			while (A[left] < pivot) left++;
			while (A[right] > pivot) right--;
			if (left <= right) {
				swap(A, left, right);
				left++;
				right--;
			}
		}
		swap(A, right + 1, high - 1);;
		return right;
	}
	public static void swap(int[] array, int low, int high) {
		int temp = array[high];
		array[high] = array[low];
		array[low] = temp;
	}
	/**
	 * Choose median from array[low], array[high], array[(high + low)/2] as pivot
	 * Rearrange value high, low, pivot
	 * @param array
	 * @param low
	 * @param high
	 * @return pivot value
	 */
	public static int medianOfThree(int[] array, int low, int high) {
		int left = array[low];
		int right = array[high];
		int mid = array[low + (high - low)/2];
		// initialization: reorder three elements
		array[low] = Math.min(Math.min(left, right), mid);  		array[high] = Math.max(Math.max(left, right), mid);
		array[low + (high - low)/2] = array[high - 1];
		int pivot = Math.max(Math.min(left,right), Math.min(Math.max(left,right),mid));
		// special case for array less than 3 elements
		if (high - low + 1 > 2) {
			array[high - 1] = pivot;
		}
		return pivot;
	}
}

```

# Merge Sort

![](http://7xihzu.com1.z0.glb.clouddn.com/201600919/merge-sort.jpg)

## Algorithm
- break down the entire array until it has single.   
- compare and merge the elements in the same group (activation record).  
- after the last merge, you will get a sorted array.  

## Analysis
- Time complextiy: $O(nlog(n))$ in worst case.  
- Space complexity: $O(n)$ auxiliary. 

## Code
```java
public class MergeSort {
	public static void main(String[] args) {
	    int[] array = {5, 5, 4, 3, 1, 3, 1, 0, 5};
	    int[] sorted = new int[array.length];
	    System.out.println("Original Array: ");
	    String sep = "";
	    for (int n : array) {
	    	System.out.print(sep + n);
	    	sep = ",";
	    }
	    mergeSort(array, 0, array.length -1, sorted);
	    System.out.println("\nSorted Array: ");
	    sep = "";
	    for (int i = 0; i < array.length; i++) {
	    	System.out.print(sep + array[i]);
	    	sep = ",";
	    }
	}
	public static void mergeSort(int[] array, int start, int end, int[] sorted) {
	    if (end - start >= 1) {
	         int mid = start + (end - start) / 2;
	         mergeSort(array, start, mid, sorted);
	         mergeSort(array, mid+1, end, sorted);
	         merge(array, start, mid, end, sorted);
	    }
	}
	
	public static void merge(int[] array, int start, int mid, int end, int[] sorted) {
	    int i = start;
	    int j = mid+1;
	    int k = 0;
	    while (i <= mid && j <= end) {
	        if (array[i] <= array[j]) {
	            sorted[k++] = array[i++];
	        } else {
	            sorted[k++] = array[j++];
	        }
	    } 
	    while (i <= mid) {
	        sorted[k++] = array[i++];
	    }
	    while (j <= end) {
	        sorted[k++] = array[j++];
	    }
	    for (int v = 0; v < k; v++) {
	        array[v+start] = sorted[v];
	    }
	}
}
```



# Insertion Sort

![](http://7xihzu.com1.z0.glb.clouddn.com/insertionSort.jpg)

## Algorithm
- start from $i = 1$  
- move every elements that is larger than `currKey` to its right until postion found to insert `currKey`.  
- insert `currKey` to $j+1$ index, where index $j$ is the last postion check that not meet the requirement (either $j \leq 0$ or `currKey` $< A[j]$)  

## Analysis
- worst case complexity $O(n^2)$

## Code

```java

	public static void main(String[] args){
		int[] A = {10, 3, 1, 2, 6, 5, 4};
		for (int i = 1; i < A.length; i++) {
			int currKey = A[i];
			int j = i - 1;
			while (j >= 0 && currKey < A[j]) {
				A[j+1] = A[j];
				j--;
			}
			A[j+1] = currKey;
		}
		print(A);
	}
	
	public static void print(int[] array) {
		for (int i = 0; i < array.length; i++) {
			System.out.print(array[i] + ",");
		}
	}

```

```java

// descending version

	public static void main(String[] args){
		int[] A = {10, 3, 1, 2, 6, 5, 4};
		for (int i = 1; i < A.length; i++) {
			int currKey = A[i];
			int j = i - 1;
			while (j >= 0 && currKey > A[j]) {
				A[j+1] = A[j];
				j--;
			}
			A[j+1] = currKey;
		}
		print(A);
	}
	
	public static void print(int[] array) {
		for (int i = 0; i < array.length; i++) {
			System.out.print(array[i] + ",");
		}
	}

```

# Reference: 

[经典排序算法 - 归并排序Merge sort](http://www.cnblogs.com/kkun/archive/2011/11/23/merge_sort.html)  

