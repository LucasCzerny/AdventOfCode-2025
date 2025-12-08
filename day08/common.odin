package aoc

import "core:strconv"
import "core:strings"

Node :: struct {
	index:     int,
	neighbors: [dynamic]int,
}

compare_points :: proc(first, second: [3]uint) -> int {
	if first.x != second.x {
		return cast(int)(first.x - second.x)
	}

	if first.y != second.y {
		return cast(int)(first.y - second.y)
	}

	return cast(int)(first.z - second.z)
}

squared_distance_single_axis :: proc(first, second: uint) -> uint {
	return (second - first) * (second - first)
}

parse_line :: proc(line: string) -> (position: [3]uint) {
	split := strings.split(line, ",")
	defer delete(split)

	for i in 0 ..< 3 {
		position[i] =
			strconv.parse_uint(split[i], 10) or_else panic("Failed to parse the position")
	}

	return position
}

