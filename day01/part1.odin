package aoc

import "core:strconv"

solve_part1 :: proc(input: []string) -> int {
	sum := 0
	position := 50

	for line in input {
		direction := line[0]

		nr_rotations :=
			strconv.parse_int(line[1:], 10) or_else panic("Failed to parse \"nr_rotations\"")

		if direction == 'L' {
			position = (position - nr_rotations) % 100
		} else if direction == 'R' {
			position = (position + nr_rotations) % 100
		}

		if position < 0 {
			position += 100
		}

		if position == 0 {
			sum += 1
		}
	}

	return sum
}

