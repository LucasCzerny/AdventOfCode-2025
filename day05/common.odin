package aoc

import "core:strconv"
import "core:strings"

Range :: struct {
	from, to: u64,
}

compare_range :: proc(first, second: Range) -> int {
	if first.from < second.from {
		return -1
	} else if first.from == second.from {
		return 0
	} else {
		return 1
	}
}

parse_range :: proc(range: string) -> Range {
	split := strings.split_n(range, "-", 2)
	defer delete(split)

	from, to: u64
	ok: bool

	from, ok = strconv.parse_u64(split[0])
	assert(ok)

	to, ok = strconv.parse_u64(split[1])
	assert(ok)

	return Range{from, to}
}

