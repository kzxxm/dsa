import Foundation
import SwiftUI

// MARK: Recursion

// Simple Example - Factorial
func factorial(_ n: Int) -> Int {
    // Base case
    if n <= 1 {
        return 1
    }
    
    // Recursive case
    return n * factorial(n - 1)
}

print(factorial(5))

// Linear Recursion Pattern
/// Fibonacci sequence
func fibonacci(_ n: Int) -> Int {
    if n <= 1 { return n }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

print(fibonacci(10))

// Tree Recursion
/// Sum of array elements
func arraySum(_ arr: [Int], _ index: Int = 0) -> Int {
    if index >= arr.count { return 0 }
    return arr[index] + arraySum(arr, index + 1)
}

print(arraySum([3, 2, 4, 5]))

// Tail Recursion
/// Tail recursive factorial
func factorialTail(_ n: Int, _ accumulator: Int = 1) -> Int {
    if n <= 1 { return accumulator }
    return factorialTail(n - 1, n * accumulator)
}

print(factorialTail(5))


// MARK: Backtracking

// Classic Example: Generating All Subsets
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


// MARK: Problems

/// 1. Power Calculation
///
/// Implement x^n using recursion

func power(_ x: Int, _ n: Int) -> Int {
    if n == 0 { return 1 }
    
    return x * power(x, n-1)
}

power(3, 3)

var num = 123

var nums: [Int: Int] = [
    1: 2,
    2: 2,
    3: 3,
    4: 1
]

