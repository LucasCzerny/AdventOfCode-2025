package aoc

import "core:fmt"
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

	from = strconv.parse_u64(split[0]) or_else fmt.panicf("Failed to parse \"from\"")
	to = strconv.parse_u64(split[1]) or_else fmt.panicf("Failed to parse \"to\"")

	return Range{from, to}
}

