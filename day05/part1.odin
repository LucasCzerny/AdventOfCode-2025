package aoc

import "core:sort"
import "core:strconv"

Ranges_Tree_Node :: struct {
	left:  ^Ranges_Tree_Node,
	right: ^Ranges_Tree_Node,
	range: Range,
}

solve_part1 :: proc(input: []string) -> int {
	ranges := make([dynamic]Range)
	defer delete(ranges)

	ingredient_id_start := 0
	for line, i in input {
		if line == "" {
			ingredient_id_start = i + 1
			break
		}

		range := parse_range(line)
		append(&ranges, range)
	}

	sort.quick_sort_proc(ranges[:], compare_range)

	sum := 0

	for i in ingredient_id_start ..< len(input) {
		id, ok := strconv.parse_u64(input[i])
		assert(ok)

		if id_is_valid(ranges, id) {
			sum += 1
		}
	}

	return sum
}

id_is_valid :: proc(ranges: [dynamic]Range, id: u64) -> bool {
	for range in ranges {
		if range.from > id {
			return false
		}

		if id <= range.to {
			return true
		}
	}

	return false
}

