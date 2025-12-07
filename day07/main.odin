package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:time"

main :: proc() {
	// odinfmt: disable
	ensure(solve_part1({
		".......S.......",
		"...............",
		".......^.......",
		"...............",
		"......^.^......",
		"...............",
		".....^.^.^.....",
		"...............",
		"....^.^...^....",
		"...............",
		"...^.^...^.^...",
		"...............",
		"..^...^.....^..",
		"...............",
		".^.^.^.^.^...^.",
		"...............",
	}) == 21)
	// odinfmt: enable

	data, err := os.read_entire_file_or_err("input/day07.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day07.txt")

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	start := time.tick_now()
	part1_result := solve_part1(lines)
	duration := time.tick_since(start)

	fmt.printfln("Part 1 result (in %fms): %d", time.duration_milliseconds(duration), part1_result)
	
	// odinfmt: disable
	ensure(solve_part2({
		".......S.......",
		"...............",
		".......^.......",
		"...............",
		"......^.^......",
		"...............",
		".....^.^.^.....",
		"...............",
		"....^.^...^....",
		"...............",
		"...^.^...^.^...",
		"...............",
		"..^...^.....^..",
		"...............",
		".^.^.^.^.^...^.",
		"...............",
	}) == 40)
	// odinfmt: enable

	start = time.tick_now()
	part2_result := solve_part2(lines)
	duration = time.tick_since(start)

	fmt.printfln("Part 2 result (in %fms): %d", time.duration_milliseconds(duration), part2_result)
}

