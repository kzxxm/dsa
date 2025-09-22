## Theory
The sliding window algorithm is an optimisation technique that reduces time complexity by maintaining a window of elements and sliding it across the data.
Instead of recalculating everything from scratch for each position, you add new elements into the window and remove elements leaving it

#### Key Concepts:
**Window:** A contiguous subarray or substring
**Sliding:** Moving the window by expanding or contracting its boundaries
**State maintenance:** Keeping track of relevant information about the current window
#### Types of Sliding Windows:
**Fixed-size window:** Window size remains constant
**Variable-size window:** Window size changes based on conditions

## Swift Implementation Patterns

#### Fixed-Size Window Template:
```
func fixedSlidingWindow<T>(_ array: [T], windowSize: Int) -> [T] {
    guard array.count >= windowSize **else** { **return** [] }

	var left = 0
	var result: [T] = []

    // Process each window
    for right in 0..<array.count {
        // Add current element to window

        // If window size is reached
        if right - left + 1 == windowSize {
            // Process current window
            // Add to result if needed

            // Slide window: remove leftmost element
            left += 1
        }
    }
    
    return result
}
```

#### Variable-Size Window Template:
```
func variableSlidingWindow<T>(_ array: [T]) -> Int {
	var left = 0
	var maxLength = 0

    for right in 0..<array.count {
        // Add array[right] to window

        // Shrink window while condition is violated
//        while *window condition violated* {
//            left += 1
//        }

        // Update result with current valid window
        maxLength = max(maxLength, right - left + 1)
    }

    return maxLength
}
```


## Practical Examples
#### Example 1: Maximum Sum of Fixed-Size Subarray
```
// Maximum Sum of Fized Size Array
func maxSumSubarray(_ nums: [Int], _ k: Int) -> Int {
    guard nums.count >= k else { return 0 }

    var windowSum = 0
    var maxSum = Int.min

    // Calculate sum of the first window
    for i in 0..<k {
        windowSum += nums[i]
    }

    maxSum = windowSum

    // Slide the window
    for i in k..<nums.count {
        
        // Minus previous number and add new one
        windowSum = windowSum - nums[i-k] + nums[i]
        
        // Check and select max of the two values
        maxSum = max(maxSum, windowSum)
    }

    return maxSum
}

// Usage
let nums = [2, 1, 5, 1, 3, 2]
print(maxSumSubarray(nums, 3))
```

#### Example 2: Longest Substring Without Repeating Characters
```
func lengthOfLongestSubstring(_ s: String) -> Int {
	let chars = Array(s)
	var charSet = Set<Character>()
	var left = 0
	var maxLength = 0
	
	for right in 0..<chars.count {
		
		// Shrink window while we have duplicates
		while charSet.contains(chars[right]) {
			charSet.remove(chars[left])
			left += 1
		}
		
		// Add current character and update length
		charSet.insert(chars[right])
		maxLength = max(maxLength, right - left + 1)
	}
	
	return maxLength
}

// Usage
print(lengthOfLongestSubstring("abcabcdacc"))
```

#### When to Use Sliding Window
Use sliding window when you need to:
- Find subarrays/substrings with specific properties
- Optimise brute force solutions that check all possible subarrays
- Process data in chunks or segments
- Maintain running calculations efficiently

**Time Complexity:** Usually reduces from `O(n2)` or `O(n3)` to `O(n)`

## Problems
#### 1. Average of Subarrays
Given an array and integer `k`, find the average of all subarrays of size k

```
func averageOfSubarrays(_ array: [Int], k: Int) -> [Double] {
	var averages = [Double]()
	var average = 0.0
	var averageSum = 0.0
	
	for i in 0..<k {
		averageSum += Double(array[i])
	}
	
	average = averageSum / Double(k)
	averages.append(average)
	
	for i in k..<array.count {
		averageSum -= Double(array[i - k])
		averageSum += Double(array[i])
		average = averageSum / Double(k)
		averages.append(average)
	}
	
	return averages
}


print(averageOfSubarrays([3, 2, 6, 4, 9, 6, 7, 8, 1], k: 3))
```

#### 2. Maximum Sum Subarray
Find the maximum sum of any subarray of size `k`

```
func maxSumSubarray(_ array: [Int], k: Int) -> Int {
	var currentSum = 0
	
	for i in 0..<k {
		currentSum += array[i]
	}
	
	var maxSum = currentSum
	
	for i in k..<array.count {
		currentSum -= array[i - k]
		currentSum += array[i]
		maxSum = max(currentSum, maxSum)
	}
	
	return maxSum
}
```

#### 3. Minimum Window
Find the smallest subarray with sum >= target value

```
func minWindow(_ array: [Int], target: Int) -> Int {
	var left = 0
	var sum = array[left]
	var minWindow = Int.max
	
	for right in 1..<array.count {
		sum += array[right]
		
		while sum >= target {
			minWindow = min(right - left + 1, minWindow)
			sum -= array[left]
			left += 1
		}
	}
	
	return minWindow
}
```

#### 4. Longest Substring with K Distinct Characters
Given a string and integer `k`, find the length of the longest substring that contains at most k distinct characters

```
func longestSubstring(_ s: String, _ k: Int) -> Int {
	var left = 0
	var maxLength = 0
	var charSet = Set<Character>()
	
	var arr = Array(s)
	
	for right in 0..<arr.count {
		charSet.insert(arr[right])
		
		while charSet.count > 2 {
			charSet.remove(arr[left])
			left += 1
		}
		
		maxLength = max(maxLength, right - left + 1)
	}
	
	return maxLength
}
```

#### 5. Fruits Into Baskets
You are visiting a farm with a row of fruit trees.
Each tree produces one type of fruit, represented by an integer.
You have x2 baskets and each basket can only hold fruits of one type.
Starting from any tree, you want to collect as many fruits as possible, but you can only move to adjacent trees.

Find the maximum number of fruits you can collect.

Examples:

Input: `fruits = [1, 2, 1]`
Output: `3`
Explanation: `You can collect all fruits: [1, 2, 1]`

Input: `fruits = [0, 1, 2, 2]`
Output: `3`
Explanation: `You can collect [1, 2, 2] (starting from index 1)`

```
func fruitsIntoBaskets(_ fruits: [Int]) -> Int {
	var fruitBaskets: [Int: Int] = [:]
	var left = 0
	var maxFruit = 0
	
	for right in 0..<fruits.count {
		fruitBaskets[fruits[right], default: 0] += 1
		
		while fruitBaskets.count > 2 {
			let fruit = fruits[left]
			fruitBaskets[fruit]! -= 1
			if fruitBaskets[fruit]! == 0 {
				fruitBaskets.removeValue(forKey: fruit)
			}
			left += 1
		}
		
		maxFruit = max(maxFruit, right - left + 1)
	}

	return maxFruit
}
```

#### 6. Permutation in String
Given 2 string, `s1` and `s2`, return `true` if `s2` contains any permutation of `s1` as a substring.
A permutation of `s1` is any rearrangement of the characters in `s1`

```
func permutation(_ s1: String, _ s2: String) -> Bool {
    var str1 = String(s1.sorted())
    var str2 = Array(s2)

    var tempStr: String = ""
    var tempStrSorted: String {
        String(tempStr.sorted())
    }
    
    var windowSize = str1.count

    for i in 0..<windowSize {
        tempStr.append(str2[i])
    }

    for i in windowSize..<str2.count {
        tempStr.removeFirst()
        tempStr.append(str2[i])
        if tempStrSorted == str1 {
            return true
        }
    }
    
    return false
}
```