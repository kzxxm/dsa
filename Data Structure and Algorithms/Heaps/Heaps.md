## What is a Heap?
A **heap** is a specialised tree-based data structure that satisfies the heap property. 
#### The Heap Property
- **Max Heap:** Every parent node is greater than or equal to its children
- **Min Heap:** Every parent node is less than or equal to its children
#### Key Characteristics
- **Complete Binary Tree:** All levels are filled except for possible the last level, which fills from left to right
- **Array Representation:** Despite being a tree, heaps are typically implemented using arrays
- **Efficient Operations:** Insertion and delete operations are `O(log n)`

## How Heaps Work
#### Array Index Relationships:
For any element at index `i` in an 0-based array:

- **Parent:** (i-1) / 2 - rounded up
- **Left Child:** 2i + 1
- **Right Child:** 2i + 2

#### Visual Example:
```
Max Heap: [50, 30, 40, 10, 20, 15, 35] 

Tree representation: 

	 50  
   /     \ 
  30     40 
 /  \   /  \ 
10  20 15  35
```