package aoc

EMPTY_FIELD :: -1

solve_part1 :: proc(input: []string) -> int {
	width := len(input[0])
	height := len(input)

	// same grid as the input but with padding
	grid := make([][]int, height + 2)
	for y in 0 ..< height + 2 {
		grid[y] = make([]int, width + 2)

		for x in 0 ..< width + 2 {
			value := -1
			if x > 0 && y > 0 && x <= width && y <= height {
				value = 0 if input[y - 1][x - 1] == '@' else -1
			}

			grid[y][x] = value
		}
	}

	sum := 0

	for y in 1 ..= height {
		for x in 1 ..= width {
			value := &grid[y][x]
			if value^ == -1 {
				continue
			}

			// increment the one to the right
			if grid[y][x + 1] != -1 {
				value^ += 1
				grid[y][x + 1] += 1
			}

			// increment the ones below
			for new_x in x - 1 ..= x + 1 {
				if grid[y + 1][new_x] == -1 {continue}

				value^ += 1
				grid[y + 1][new_x] += 1
			}

			if value^ < 4 {
				sum += 1
			}
		}
	}

	return sum
}

