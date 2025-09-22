import Foundation



// MARK: Declaration and Initialisation

// Empty Dictionary
var scores: [String: Int] = [:]

// Simplified notation:
var scores1 = [String:Int]()

// Dictionary with initial values
var fruits = ["apple": 5, "banana": 3, "orange": 8]

// Explicit type annotations
var inventory: [String: Int] = ["laptops": 10, "phones": 15]



// MARK: Basic Operations

var studentGrades = [String: Int]()

// Adding/Updating values
studentGrades["Alice"] = 95
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


// MARK: Essential Hash Map Patterns for Coding Interviews

/// Frequency Counting Pattern

func characterFrequency(_ text: String) -> [Character: Int] {
    var frequency = [Character: Int]()
    
    for char in text {
        frequency[char, default: 0] += 1
    }
    
    return frequency
}

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


/// Two Sum

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


/// Grouping Pattern

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


/// Caching/Memoization Pattern

class FibonacciCalculator {
    private var memo: [Int: Int] = [:]
    
    func fibonacci(_ n: Int) -> Int {
        if n <= 1 { return n }
        
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


/// Sliding Window with Hash Map

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



// MARK: Advanced Hash Map Techniques

/// Multiple Hash Maps for Different Views

func intersectionOfArrays(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    let set1 = Set(nums1)
    let set2 = Set(nums2)
    return Array(set1.intersection(set2))
}

intersectionOfArrays([1, 2, 2, 3, 4, 7], [2, 3, 3, 4, 5, 6, 7, 9])

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

intersectWithCounts([1, 2, 2, 3, 4, 7], [2, 3, 3, 4, 5, 6, 7, 9])


/// Hash Map with Custom Objects

struct Person: Hashable {
    let name: String
    let age: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }
}

var personScores: [Person: Int] = [:]
let alice = Person(name: "Alice", age: 25)
personScores[alice] = 95


/// Prefix Sum with Hash Map

func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var prefixSumCount: [Int: Int] = [0: 1]
    var currentSum = 0
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



// MARK: Common Interview Problems and Solutions

/// Valid Anagram

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


/// First Non-Repeating Character

func firstUniqueChar(_ s: String) -> Int {
    var charCount: [Character: Int] = [:]
    
    // Count frequencies of each character
    for char in s {
        charCount[char, default: 0] += 1
    }
    
    // Find first character with count of 1
    for (index, char) in s.enumerated() {
        if charCount[char] == 1 {
            return index
        }
    }
    
    return -1
}

firstUniqueChar("the quick brown fox jumped over the lazy dog")


/// Group Shifted String

func groupStrings(_ strings: [String]) -> [[String]] {
    var groups: [String: [String]] = [:]
    
    func getKey(_ str: String) -> String {
        guard str.count > 1 else { return "0" }
        
        let chars = Array(str)
        var key = ""
        
        for i in 1..<chars.count {
            var diff = Int(chars[i].asciiValue!) - Int(chars[i - 1].asciiValue!)
            if diff < 0 {
                diff += 26
            }
            
            key += "\(diff),"
        }
        
        return key
    }
    
    for string in strings {
        let key = getKey(string)
        groups[key, default: []].append(string)
    }
    
    return Array(groups.values)
}

groupStrings(["abc", "deq", "cba", "xyz"])

