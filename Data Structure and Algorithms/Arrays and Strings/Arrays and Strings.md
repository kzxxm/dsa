## Array Fundamentals
### What is an array?
An array is a linear data structure that stores elements of the same type in contiguous memory locations. Each element can be accessed via an index.
##### Key properties:
- **Dynamic size** in swift, different in other languages
- **Random access:** `O(1)` time to access any element
- **Contiguous memory:** Elements are stored next to each other
- **Zero-indexed:** First element is at index '0'

### Memory Layout and Performance
`let array = [10, 20, 30, 40, 50]`
`// Memory: [10][20][30][40][50]`
`// Index:   0   1   2   3   4  `

#### Time Complexities:
- Access by index: `O(1)`
- Search (unsorted): `O(n)`
- Search (sorted): `O(log n)` (with binary search)
- Insertion at end: `O(1)`
- Insertion at beginning/middle: `O(n)`
- Deletion: `O(n)`

### Index Manipulation and Boundary Checking

Safe Index Access Pattern:
```
extension Array {
    func safeElement(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Common boundary checks
func processArray<T>(_ arr: [T]) -> [T] {
    guard !arr.isEmpty else { return [] }    
    // First element
    let first = arr[0]
    // or safer: let first = arr.first
    
    // Last element
    let last = arr[arr.count - 1]
    // or safer: let last = arr.last
    
    // Safe iteration
    for i in arr.indices {        
	    // Safe to access arr[i]
        print(arr[i])
    }
    
    return arr
}
```

Common Index Manipulation Patterns:
```
let arr = [1, 2, 3, 4, 5] 

// Forward traversal 
for i in 0..<arr.count { 
	print(arr[i]) 
} 

// Backward traversal 
for i in (0..<arr.count).reversed() { 
	print(arr[i]) 
} 

// Skip patterns (every 2nd element) 
for i in stride(from: 0, to: arr.count, by: 2) { 
	print(arr[i]) 
} 

// Window access 
let k = 3 
for i in 0...(arr.count - k) { 
	let window = Array(arr[i..<i+k]) 
	print(window) 
}
```

## In-Place Modifications vs. Creating New Arrays
### In-Place Modifications
**Advantages:**
- Space complexity: `O(1)`
- Memory efficient
- Faster for large datasets

**Disadvantages:**
- Original data is lost
- Can be more complex to implement
- Risk of data corruption if algorithm fails

```
// In-place example: Reverse array 
func reverseInPlace<T>(_ arr: inout [T]) { 
	var left = 0 
	var right = arr.count - 1 
	while left < right { 
		arr.swapAt(left, right) 
		left += 1 
		right -= 1 
	} 
} 

// Usage: 
var numbers = [1, 2, 3, 4, 5] 
reverseInPlace(&numbers) 
print(numbers) 
// [5, 4, 3, 2, 1] 

// Time: O(n), Space: O(1)
```

### Creating New Arrays
**Advantages:**
- Original data is preserved
- Easier to debug
- Safer implementation

**Disadvantages:**
- Space complexity: `O(n)`
- Additional memory allocation overhead

```
// New array example: Reverse array 
func reverseNewArray<T>(_ arr: [T]) -> [T] { 
	return arr.reversed() 
} 

// Or with explicit creation: 
func reverseExplicit<T>(_ arr: [T]) -> [T] { 
	var result: [T] = [] 
	for i in (0..<arr.count).reversed() { 
		result.append(arr[i]) 
	} 
	return result 
} 

// Time: O(n), Space: O(n)
```

## Two Pointer Technique
### When to Use Two Pointers
- Searching for pairs in sorted arrays
- Reversing/rearranging elements
- Finding palindromes
- Merging sorted arrays
- Removing duplicates

#### Same Direction Two Pointers
**Pattern:** Both pointers move in the same direction, usually at different speeds
```
// Example: Remove duplicates from sorted array 
func removeDuplicates(_ nums: inout [Int]) -> Int { 
	guard nums.count > 1 else { return nums.count } 
	var writeIndex = 1  // Where to write next unique element 
	
	for readIndex in 1..<nums.count { 
		if nums[readIndex] != nums[readIndex - 1] { 
			nums[writeIndex] = nums[readIndex] 
			writeIndex += 1 
		} 
	} 
	
	return writeIndex 
} 

// Time: O(n), Space: O(1)
```

#### Opposite Direction Two Pointers
**Pattern:** One pointer starts from beginning, other from end, they move towards each other
```
// Example: Two Sum in sorted array 
func twoSumSorted(_ nums: [Int], _ target: Int) -> [Int] { 
	var left = 0 
	var right = nums.count - 1 
	while left < right { 
		let currentSum = nums[left] + nums[right] 
		
		if currentSum == target { 
			return [left, right] 
		} else if currentSum < target { 
			left += 1 
		} else { 
			right -= 1 
		} 
	} 
	
	return [] 
} 

// Time: O(n), Space: O(1)
```


```
# There is a self-driving car in the middle lane at the beginning of a 3-lane, 1000 unit long highway.

# Along the road, there are some obstacles (marked "O"). If the car overlaps an obstacle, it crashes and cannot continue.

# The car has a very limited memory. It can accept a string of 10 characters, which can be D, R, or L.

# The letter D instructs the car to drive forward 1 unit, the letters R or L will shift the car to the right or left without moving forward.

# The car continuously loops over this string of 10 commands, until it reaches the end, crashes, or runs out of fuel.

# Find a string of 10 characters that brings the car to the end of the road.


# Sample Input:

.O.......O......O..... 
...O....O......O... 
.OOOO...O..O...OO.O..


# Solution:

Correct Answer: DDLDDDRDDD
```