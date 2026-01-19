### DFS Template
```
let directions = [
    (1, 0),   // down
    (-1, 0),  // up
    (0, 1),   // right
    (0, -1)   // left
]

func dfs(_ r: Int, _ c: Int) {
	// 1: Boundary check
	if r < 0 || c < 0 || r >= rows || c >= cols {
		return 
	}
	
	// 2: Visited/invalid cell check 
	if grid[r][c] == "0" {
		return
	}
	
	// 3: Mark as visited
	grid[r][c] == "0"
	
	// 4: Explore neighbours 
	for (dr, dc) in directions {
		dfs(r + dr, c + dc)
	}
}
```

### Example:  Number of Islands
```
func numIslands(_ grid: [[Character]]) -> Int {
	let rows = grid.count
	let columns = grid[0].count
	let directions = [
		(1, 0),
		(-1, 0),
		(0, 1),
		(0, -1)
	]  
	
	var islands = 0
	var visited = grid
	
	func dfs(_ r: Int, _ c: Int) {
		// Boundary check
		if r < 0 || c < 0 || r >= rows || c >= columns {
			return
		}
		
		// Check if visited
		if visited[r][c] == "0" {
			return
		}
		
		// Mark as visited
		visited[r][c] = "0"
		  
		// Search neighbours
		for (dr, dc) in directions {
			dfs(r + dr, c + dc)
		}
	}
	
	for r in 0..<rows {
		for c in 0..<columns {
			if visited[r][c] == "1" {
				dfs(r, c)
				islands += 1
			}
		}
	}
	
	return islands
}
```