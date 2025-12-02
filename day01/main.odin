package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:time"

main :: proc() {
	ensure(solve_part1({"L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82"}) == 3)

	data, err := os.read_entire_file_or_err("input/day01.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day01.txt")

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	start := time.tick_now()
	part1_result := solve_part1(lines)
	duration := time.tick_since(start)

	fmt.printfln("Part 1 result (in %fms): %d", time.duration_milliseconds(duration), part1_result)

	ensure(solve_part2({"L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82"}) == 6)
	ensure(solve_part2({"L1000"}) == 10)

	start = time.tick_now()
	part2_result := solve_part2(lines)
	duration = time.tick_since(start)

	fmt.printfln("Part 2 result (in %fms): %d", time.duration_milliseconds(duration), part2_result)
}

