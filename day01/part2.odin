package aoc

import "core:strconv"

solve_part2 :: proc(input: []string) -> int {
	sum := 0
	position := 50

	for line in input {
		direction_str := line[0]

		nr_rotations, ok := strconv.parse_int(line[1:], 10)
		assert(ok)

		direction := -1 if direction_str == 'L' else 1

		for nr_rotations != 0 {
			position += direction
			nr_rotations -= 1

			if position == -1 {
				position = 99
			} else if position == 100 {
				position = 0
			}

			if position == 0 {
				sum += 1
			}
		}
	}

	return sum
}

