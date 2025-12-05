package aoc

import "core:strconv"
import "core:strings"
import "core:sync"

Thread_Data :: struct {
	from, to:  i64,
	sum:       ^u64,
	sum_mutex: ^sync.Mutex,
}

NR_THREADS :: 16
N :: 12 // max nr of digits in the input

parse_range :: proc(range: string) -> (i64, i64) {
	bounds := strings.split(range, "-")
	defer delete(bounds)

	from, to: i64
	ok: bool

	from, ok = strconv.parse_i64(bounds[0], 10)
	assert(ok)

	to, ok = strconv.parse_i64(bounds[1], 10)
	assert(ok)

	return from, to
}

