## What is Recursion?
Recursion is a problem solving technique where a function calls itself to solve smaller instances of the same problem. Every recursive solution has two essential components:

1. **Base Case:** The condition that stops the recursion
2. **Recursive Case:** The function calling itself with a modified input

### Basic Structure in Swift

```
func recursiveFunction(parameter: Type) -> ReturnType {
	// Base case - when to stop
	
	if baseCondition {
		return baseValue
	}
	
	// Recursive case - call itself with modified input
	return recursiveFunction(parameter: modifiedParameter)
}
```

### Simple Example: Factorial

```
func factorial(_ n: Int) -> Int {
	// Base case
	if n <= 1 {
		return 1
	}
	
	// Recursive case
	return n * factorial(n - 1)
}
```

### Key Recursion Pattern
#### 1. Linear Recursion
Each function call makes exactly one recursive call.

```
func fibonacci(_ n: Int) -> Int {
	if n <= 1 { return n }
	return fibonacci(n - 1) + fibonacci(n - 2)
}
```
#### 2. Tree Recursion
Each function call makes multiple recursive calls.

```
func arraySum(_ arr: [Int], _ index: Int = 0) -> Int {
	if index >= arr.count { return 0 }
	return arr[index] + arraySum(arr, index + 1)
}
```
#### 3. Tail Recursion
The recursive call is the last operation in the function.

```
func factorialTail(_ n: Int, _ accumulator: Int = 1) -> {
	if n <= 1 { return accumulator }
	return factorialTail(n - 1, n * accumulator)
}
```



## Backtracking

### What is Backtracking?
Backtracking is an algorithmic approach that incrementally builds solutions and abandons ('backtracks') partial solutions that cannot lead to a valid complete solutions. It's essentially a refined brute force approach.

#### Backtracking Template
```
func backtrack(currentSolution: inout [Element], allSolutions: inout [[Element]], remainingChoices: [Choice]) {

	// Base case: Solution is complete
	if isComplete(currentSolution) {
		allSolutions.append(Array(currentSolution))
		return
	}
	
	// Try each possible choice
	for choice in remainingChoices {
		
		// Make the choice
		if isValid(choice, currentSolution) {
			currentSolution.append(choice)
			
			// Recurse with updated state
			backtrack(
				currentSolution: &currentSolution, 
				allSolutions: &allSolutions,
				remainingChoices: getNextChoices(choice)
			)
			
			// Backtrack (undo the choice)
			currentSolution.removeLast()
		}
	}
}
```

#### Classic Example: Generating All Subsets
```
func subsets(_ nums: [Int]) -> [[Int]] {
    var result: [[Int]] = []
    var currentSubset: [Int] = []

    func backtrack(_ index: Int) {
    
        // Base case: processed all elements
        if index == nums.count {
            result.append(Array(currentSubset))
            return
        }

        // Choice 1: Don't include current element
        backtrack(index + 1)

        // Choice 2: Include current element
        currentSubset.append(nums[index])
        backtrack(index + 1)
        currentSubset.removeLast()
    }

    backtrack(0)
    return result
}

subsets([1, 2, 3])
```

#### Advanced Example: N Queens Problem
```
// Advanced Example: N-Queens Problem

func solveNQueens(_ n: Int) -> [[String]] {
    var result: [[String]] = []
    var board = Array(repeating: Array(repeating: ".", count: n), count: n)

    func isValid(_ row: Int, _ col: Int) -> Bool {

        // Check column
        for i in 0..<row {
            if board[i][col] == "Q" { return false }
        }

        // Check diagonal (top-left to bottom-right)
        var i = row - 1, j = col - i
        while i >= 0 && j >= 0 {
            if board[i][j] == "Q" { return false }
            i -= 1
            j -= 1
        }

        // Check diagonal (top-right to bottom-left)
        i = row - 1; j = col + 1
        while i >= 0 && j < n {
            if board[i][j] == "Q" { return false }
            i -= 1
            j += 1
        }

        return true
    }

    func backtrack (_ row: Int) {
        if row == n {
            result.append(board.map { String($0.joined()) })
            return
        }

        for col in 0..<n {
            if isValid(row, col) {
                board[row][col] = "Q"
                backtrack(row + 1)
                board[row][col] = "." // Backtrack
            }
        }
    }

    backtrack(0)
    return result
}

print(solveNQueens(4))
```