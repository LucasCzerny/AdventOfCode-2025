package aoc

solve_part2 :: proc(input: []string) -> int {
	start_pos := 0
	for input[0][start_pos] != 'S' {
		start_pos += 1
	}

	cache := make(map[[2]int]int)
	defer delete(cache)

	return count_splits({start_pos, 0}, input, &cache) + 1
}

count_splits :: proc(pos: [2]int, input: []string, cache: ^map[[2]int]int) -> int {
	nr_splits := 0

	for row in pos.y + 1 ..< len(input) {
		if input[row][pos.x] == '^' {
			nr_splits += 1

			deltas :: [2]int{-1, 1}
			for delta_x in deltas {
				new_pos := [2]int{pos.x + delta_x, row}

				if cache[new_pos] == 0 {
					cache[new_pos] = count_splits(new_pos, input, cache)
				}

				nr_splits += cache[new_pos]
			}

			break
		}
	}

	return nr_splits
}

