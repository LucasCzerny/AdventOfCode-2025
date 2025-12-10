package aoc

solve_part1 :: proc(input: []string) -> int {
	nr_points := len(input)

	points := make([][2]int, nr_points)
	defer delete(points)

	for line, i in input {
		point := parse_line(line)
		points[i] = point
	}

	max_area := 0

	for first_index in 0 ..< nr_points {
		for second_index in 0 ..< nr_points {
			if first_index == second_index {
				continue
			}

			first := points[first_index]
			second := points[second_index]

			area := (1 + abs(first.x - second.x)) * (1 + abs(first.y - second.y))

			if area > max_area {
				max_area = area
			}
		}
	}

	return max_area
}

