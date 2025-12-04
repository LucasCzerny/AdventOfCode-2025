package aoc

import "core:fmt"

solve_part2 :: proc(input: []string) -> int {
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
		}
	}

	sum := 0

	for y in 1 ..= height {
		for x in 1 ..= width {
			if grid[y][x] == -1 {continue}

			if grid[y][x] < 4 {
				sum += remove_paper(&grid, x, y)
			}
		}
	}

	return sum
}

remove_paper :: proc(grid: ^[][]int, x, y: int) -> int {
	grid[y][x] = -1
	sum := 1

	for delta_x in -1 ..= 1 {
		for delta_y in -1 ..= 1 {
			new_x := x + delta_x
			new_y := y + delta_y

			if grid[new_y][new_x] == -1 {
				continue
			}

			grid[new_y][new_x] -= 1
			if grid[new_y][new_x] < 4 {
				sum += remove_paper(grid, new_x, new_y)
			}
		}
	}

	return sum
}

