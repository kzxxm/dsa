### BFS Template
```
let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
var queue = [(Int, Int)]()
var index = 0

queue.append((startRow, startCol))

while index < queue.conut {
	let (r, c) = queue[index]
	index += 1
	
	for (dr, dc) in direction {
		let nr = r + dr
		let nc = c + dc
		
		if nr >= 0, nc >= 0, nr < rows, nc < cols {
			// condition
		}
	}
}
```