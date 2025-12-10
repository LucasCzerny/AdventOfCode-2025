package aoc

import "core:strconv"
import "core:strings"

parse_line :: proc(line: string) -> [2]int {
	split := strings.split(line, ",") or_else panic("Failed to split the line")
	defer delete(split)

	x := strconv.parse_int(split[0]) or_else panic("Failed to parse \"x\"")
	y := strconv.parse_int(split[1]) or_else panic("Failed to parse \"y\"")

	return {x, y}
}

