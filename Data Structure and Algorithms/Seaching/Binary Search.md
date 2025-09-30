## What is Binary Search?
Binary search is a **divide-and-conquer** algorithm that finds the position of a target balue within a **sorted array** by repeatedly dividing the search interval in half.

#### Key Requirements:
- The array **must be sorted** (ascending/descending)
- We need random access to elements (arrays work perfectly in this instance)
#### Why is it so important for interviews?
- **Time Complexity:** `O(log n)` - incredibly fast, even in huge datasets
- **Space Complexity:** `O(1)` for iterative implementation
- **Versatility:** Can be adapted to solve many problems
- **Frequency:** Appears in 20-30% of technical interviews

## How Binary Search Works

A way to picture binary search is to think of a number between 1 and 100.

1. **Start in the middle:** Guess 50 
2. **Get feedback:** "Too high" or "Too low"
3. **Eliminate half:** Discard half of the possibilities
4. **Repeat:** Until you find the answer

#### Visual Example
```
Array: [1, 3, 5, 7, 9, 11, 13, 15, 17, 29]
Target: 7


Step 1: Check middle (index: 4, value: 9)
Array: [1, 3, 5, 7, 9, 11, 13, 15, 17, 29]
Index:  0  1  2  3  4   5   6   7   8   9
                    ^ Middle of array

9 is greater than the target (7) so we discard the right half


Step 2: Check middle of left half (index: 1, value: 3)
Array: [1, 3, 5, 7]
Index:  0  1  2  3
           ^ Middle of array

3 is smaller than the target (7) so we discard the left half


Step 3: Check midle of remaining (index: 3, value 7)
Array: [5, 7]
Index:  0  1
           ^ Middle of array

Target found.
```

## Implementing a Binary Search in Swift

#### Basic Binary Search (Finding exact Match)
```
func binarySearch<T: Comparable>(_ array: [T], target: T) -> Int? {
    var left = 0
    var right = array.count - 1

    while left <= right {
        let middle = left + (right - left) / 2  // To prevent overflow
        if array[middle] == target {
            return middle
        } else if array[middle] < target {
            left = middle + 1   // Search right half
        } else {
            right = middle - 1  // Search left half
        }
    }

    return nil  // Target not found
}

// Example usage:
let numbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

if let index = binarySearch(numbers, target: 7) {
    print("Found 7 at index: \(index)") // Found 7 at index 3
} else {
    print("Not found")
}
```