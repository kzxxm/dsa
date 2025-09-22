import Foundation

// MARK: Basic Binary Search (Finding Exact Match)
func binarySearch<T: Comparable>(_ array: [T], target: T) -> Int? {
    var left = 0
    var right = array.count - 1
    
    while left <= right {
        let middle = left + (right - left) / 2  // To prevent overflow
        
        if array[middle] == target {
            return middle
        } else if array[middle] < target {
            left = middle + 1   // Search right half
        } else {
            right = middle - 1  // Search left half
        }
    }
    
    return nil  // Target not found
}

// Example usage:
let numbers = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

if let index = binarySearch(numbers, target: 7) {
    print("Found 7 at index: \(index)") // Found 7 at index 3
} else {
    print("Not found")
}


// MARK: Lower Bound (First Position Where Element Could Be Inserted)
func lowerBound<T: Comparable>(_ array: [T], target: T) -> Int {
    var left = 0
    var right = array.count - 1
    
    while left < right {
        let middle = left + (right - left) / 2
        
        if array[middle] < target {
            left = middle + 1
        } else {
            right = middle
        }
    }
    
    return left
}

// Example Usage:
let arr = [1, 3, 3, 3, 7, 9]
print(lowerBound(arr, target: 3)) //  1 (first occurence of 3)
print(lowerBound(arr, target: 5)) //  4 (where 5 should be inserted)


// MARK: Upper Bound (Last Position Where Element Could Be Inserted)
func upperBound<T: Comparable>(_ array: [T], target: T) -> Int {
    var left = 0
    var right = array.count - 1
    
    while left < right {
        let middle = left + (right - left) / 2
        
        if array[middle] <= target {
            left = middle + 1
        } else {
            right = middle
        }
    }
    
    return left
}

// Example usage
print(upperBound(arr, target: 3)) //  4 (after last occurence of 3)
