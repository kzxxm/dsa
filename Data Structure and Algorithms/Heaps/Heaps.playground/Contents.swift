import Foundation

// MARK: Building a Heap from Scratch
struct Heap<T: Comparable> {
    private var elements: [T] = [] // T denotes a generic type which will be set by the heap later, ensuring all elements are comparable
    private let isMaxHeap: Bool // true for max-heap, false for min-heap
    
    init(isMaxHeap: Bool = true) {
        self.isMaxHeap = isMaxHeap
    }
    
    //  Basic Properties
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    var peek: T? {
        return elements.first
    }
    
    
    //  Index Calculations
    private func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    private func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    
    //  Heap Property Checking
    private func compare(_ first: T, _ second: T) -> Bool {
        if isMaxHeap {
            // Max heap, parent should be larger
            return first > second
        } else {
            // Min heap, parent should be smaller
            return first < second
        }
    }
    
    
    //  Insertion (Bubble Up)
    mutating func insert(_ element: T) {
        elements.append(element)
        bubbleUp(from: elements.count - 1)
    }
    
    private mutating func bubbleUp(from index: Int) {
        let parent = parentIndex(of: index)
        
        // Base case - Reached root or heap property satisfied
        guard index > 0 && compare(elements[index], elements[parent]) else {
            return
        }
        
        elements.swapAt(index, parent)
        bubbleUp(from: parent) // Recursively bubble up
    }
    
    
    //  Removal (Bubble Down)
    mutating func removeRoot() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        if elements.count == 1 {
            return elements.removeFirst()
        }
        
        let root = elements[0]
        elements[0] = elements.removeLast()
        bubbleDown(from: 0)
        return root
    }
    
    private mutating func bubbleDown(from index: Int) {
        let leftChild = leftChildIndex(of: index)
        let rightChild = rightChildIndex(of: index)
        var targetIndex = index
        
        // Find the appropriate child to swap with
        if leftChild < elements.count && compare(elements[leftChild], elements[targetIndex]) {
            targetIndex = leftChild
        }
        
        if rightChild < elements.count && compare(elements[rightChild], elements[targetIndex]) {
            targetIndex = rightChild
        }
        
        // If we found a child to swap with, do so and continue bubbling down
        if targetIndex != index {
            elements.swapAt(index, targetIndex)
            bubbleDown(from: targetIndex) // Recursively bubble down
        }
    }
}
