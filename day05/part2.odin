package aoc

import "core:sort"

solve_part2 :: proc(input: []string) -> u64 {
	ranges := make([dynamic]Range)
	defer delete(ranges)

	for line in input {
		if line == "" {
			break
		}

		range := parse_range(line)
		append(&ranges, range)
	}

	sort.quick_sort_proc(ranges[:], compare_range)

	sum: u64 = 0
	current := ranges[0]

	for range in ranges[1:] {
		if range.from <= current.to + 1 {
			current.to = max(current.to, range.to)
		} else {
			sum += current.to - current.from + 1
			current = range
		}
	}

	sum += current.to - current.from + 1

	return sum
}

