package aoc

solve_part1 :: proc(input: []string) -> int {
	width := len(input[0])
	beams := make([]byte, width)
	defer delete(beams)

	start_pos := 0
	for input[0][start_pos] != 'S' {
		start_pos += 1
	}

	beams[start_pos] = 1
	nr_splits := 0

	for row := 2; row < len(input) - 1; row += 1 {
		for char, column in input[row] {
			if char != '^' {continue}
			if beams[column] == 0 {continue}

			beams[column] = 0
			beams[column - 1] = 1
			beams[column + 1] = 1

			nr_splits += 1
		}
	}

	return nr_splits
}

