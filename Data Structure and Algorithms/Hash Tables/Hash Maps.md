## What is a Hash Map?
A **hash map** is a data structure that stores key-value pairs and allows you to quickly look up, insert and delete values based on their keys. 

They work similarly to how a real world dictionary does, in the sense that you look up a word (key) to find its definition (value), or similarly like how you would search a name( key) in a phone book to find a phone number (value).

In Swift, a hash map is known as a `Dictionary`.

#### Key Characteristics:
- **Fast lookups:** Finding a value takes `O(1)` average time complexity
- **Key-value pairs:** Each piece of data has a unique identifier (key) and associated data (value)
- **Unique keys:** Each key can only appear once, but values can be duplicated
- **Unordered:** Element's don't maintain their insertion order (although swift dictionaries do preserve insertion order)


## How do Hash Maps Work?

### The Hash Function
A hash map uses a **hash function** to convert keys into array indices:

1. **Hashing:** The key is passed through a hash function which produces a hash code (integer)
2. **Indexing:** The hash code is converted to an array index (using modulo: `index = hash(key) mod arraySize)
3. **Storage:** The key-value pair is stored at that array index

### Collision Handling
When two different keys hash to the same index, this is known as a **collision**. 

Swift uses **separate chaining**, which means storing multiple key-value pairs at the same index using a linked structure.

### Time Complexity
- **Average Case:** `O(1)` for lookup, insertion and deletion
- **Worst Case:** `O(n)` when many collisions occur
- **Space Complexity:** `O(n)` where `n` is the number of key-value pairs


## Swift Dictionary Basics
#### Declaration and Initialisation
```
// Empty Dictionary
var scores: [String: Int] = [:]

// Simplified notation:
var scores1 = [String:Int]()

// Dictionary with initial values
var fruits = ["apple": 5, "banana": 3, "orange": 8]

// Explicit type annotations
var inventory: [String: Int] = ["laptops": 10, "phones": 15]
```

#### Basic Operations
```
var studentGrades = [String: Int]()

// Adding/Updating values
studentGrades["Alice"] = 9
studentGrades["Bob"] = 87
studentGrades.updateValue(92, forKey: "Charlie")

// Accessing values
if let aliceGrade = studentGrades["Alice"] {
    print("Alice's Grade: \(aliceGrade)")
}

// Accessing with default value
let davidGrade = studentGrades["David", default: 0]

// Removing values
studentGrades["Bob"] = nil
studentGrades.removeValue(forKey: "Charlie")

// Check if key exists
if studentGrades.keys.contains("Alice") {
    print("Alice is in the dictionary")
}
```



## Essential Hash Map Patterns for Coding Interviews

#### Frequency Coding Pattern

**Use Case:** Count occurrences of elements
**Time Complexity:** `O(n)`

```
func characterFrequency(_ text: String) -> [Character: Int] {
    var frequency = [Character: Int]()
    
	for char in text {
        frequency[char, **default**: 0] += 1
    }
    
    return frequency
} 

// Example Usage
let text = "hello world"
let freq = characterFrequency(text)
print(freq)

// Finding the most frequent character
func mostFrequentCharacter(_ text: String) -> Character? {
    let freq = characterFrequency(text)
    return freq.max(by: {$0.value < $1.value})?.key
}

if let mostFrequent = mostFrequentCharacter(text) {
    print(mostFrequent)
}
```

#### Two Sum
**Use Case:** Find pairs of numbers that sum to a target
**Time Complexity:** `O(n)`

```
func twoSum(_ nums: [Int], _ target: Int) -> [Int]? {
    var numToIndex = [Int: Int]()

    for (index, num) in nums.enumerated() {
        let complement = target - num
        
        if let complementIndex = numToIndex[complement] {
            return[complementIndex, index]
        }

        numToIndex[num] = index
    }

    return nil
}

let numbers = [2, 7, 11, 15]
let target = 9

if let indices = twoSum(numbers, target) {
    print("Indices: \(indices)")
}
```

#### Grouping Pattern
**Use Case:** Group elements by some property
**Time Complexity:** `O(n)`

```
func groupAnagrams(_ strs: [String]) -> [[String]] {
	var groups = [String: [String]]()

    for str in strs {
        let sortedStr = String(str.sorted())
        groups[sortedStr, default: []].append(str)
    }

    return Array(groups.values)
}

let words = ["eat", "tea", "tan", "ate", "nat", "bat"]
let anagramGroups = groupAnagrams(words)

print(anagramGroups)
```

#### Caching/Memoization Pattern
**Use Case:** Store computed results to avoid redundant calculations

```
class FibonacciCalculator {
    private var memo: [Int: Int] = [:]

    func fibonacci(_ n: Int) -> Int {
        if n <= 1 { **return** n }

        if let cached = memo[n] {
            return cached
        }

        let result = fibonacci(n - 1) + fibonacci(n - 2)
        memo[n] = result
        return result
    }
}

let calculator = FibonacciCalculator()
print(calculator.fibonacci(10))
```

#### Sliding Window with Hash Map
**Use Case:** Track elements in a moving window
**Time Complexity:** `O(n)`

```
func lengthOfLongestSubstring(_ s: String) -> Int {
	var charIndex: [Character: Int] = [:]
	var maxLength = 0
	var start = 0
	
	for (end, char) in s.enumerated() {
		if let lastIndex = charIndex[char], lastIndex >= start {
			start = lastIndex + 1
		}
		
		charIndex[char] = end
		maxLength = max(maxLength, end - start + 1)
	}
	
	return maxLength
} 

let str = "abcabcbb"
print(lengthOfLongestSubstring(str))
```



## Advanced Hash Map Techniques

#### Multiple Hash Maps for Different Views
```
func intersectionOfarrays(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
	let set1 = Set(nums1)
	let set2 = Set(nums2)
	return Array(set1.intersection(set2))
}

// For counting intersections
func intersectWithCounts(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
	var count1: [Int: Int] = [:]
	var result: [Int] = []
	
	// Count frequency in first array
	for num in nums1 {
		count1[num, default: 0] += 1
	}
	
	// Check second array against counts
	for num in nums2 {
		if let count = count1[num], count > 0 {
			result.append(num)
			count1[num] = count - 1
		}
	}
	
	return result
}
```

#### Hash Map with Custom Objects

```
struct Person: Hashable {
	let name: String
	let age: Int
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(name)
		hasher.combine(age)
	}
}

var personScores: [Person: Int] = [:]
let alice: Person(alice, 25)
personScores[alice] = 95
```

#### Prefix Sum with Hash Map

```
func subArray(_ nums: [Int], _ k: Int) -> Int {
	var prefixSumCount: [Int: Int] = [0: 1]
	var currentsum = 0
	var count = 0
	
	for num in nums {
		currentSum += num
		
		// Check if (currentSum - k) exists
		if let previousCount = prefixSumCount[currentSum - k] {
			count += previousCount
		}
		
		// Update prefix sum count
		prefixSumCount[currentSum, default: 0] += 1
	}
	
	return count
}

subarraySum([2, 3, 7, 5, 1, 8, 2], 10)
```



## Common Interview Problems and Solutions

#### Valid Anagram

```
func isAnagram(_ s: String, _ t: String) -> Bool {
	guard s.count == t.count else { return false }
	
	var charCount: [Character: Int] = [:]
	
	for char in s {
		charCount[char, default: 0] += 1
	}
	
	for char in t {
		guard let count = charCount[char], count > 0 else {
			return false
		}
		
		charCount[char] = count - 1
	}
	
	return true
}

isAnagram("listen", "silent")
isAnagram("tone", "nite")
```

#### First Non-Repeating Character

```
func firstUniqueChar(_ s: String) -> Int {
	var charCount: [Character: Int] = [:]
	
	for char in s {
		charCount[char, default: 0] += 1
	}
	
	for (index, char) in s.enumerated {
		if charCount[char] == 1 {
			return index
		}
	}
	
	return -1
}

firstUniqueChar("the quick brown fox jumped over the lazy dog")
```

#### Group Shifted Strings
```
func groupStrings(_ strings: [String]) -> [[String]] {
	var groups: [String: [String]] = [:]
	
	func getKey(_ str: String) -> String {
		guard str.count > 1 else { return "0" }
		
		let chars = Array(str)
		var key = ""
	for i in 1..<chars.count {
		var diff = Int(chars[i].asciiValue!) - Int(chars[i - 1].asciiValue!)
		}
		if diff < 0 {
			diff += 26
		}
		
		key += "\(diff),"
	}
	
	return key
	
}
```


### Common Pitfalls to Avoid

- **Force Unwrapping:** Always use optional binding or default values
- **Mutating while iterating:** Create a copy if you need to modify during iteration
- **Assuming order:** Don't rely on dictionary order for correctness
- **Hash collision handling:** Understand that the worst-case performance can degrade

### When to Use Hash Maps vs Other Data Structures

**Use Hash Maps when:**
- You need fast lookups by key (`O(1)` average)
- You're counting frequencies
- You need to group data by some property
- You're implementing caching/memoization

**Use Arrays when:**
- You need ordered data
- You're accessing by index
- You need to maintain insertion order strictly

**Use Sets when:**
- You only care about uniqueness
- You need set operations (union, intersection)