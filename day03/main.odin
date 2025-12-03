package aoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:time"

main :: proc() {
	data, err := os.read_entire_file_or_err("input/day03.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day03.txt")

	ensure(solve_part1("987654321111111") == 98)
	ensure(solve_part1("811111111111119") == 89)
	ensure(solve_part1("234234234234278") == 78)
	ensure(solve_part1("818181911112111") == 92)

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	part1_result := 0

	start := time.tick_now()
	for line in lines {
		part1_result += solve_part1(line)
	}
	duration := time.tick_since(start)

	fmt.printfln("Part 1 result (in %fms): %d", time.duration_milliseconds(duration), part1_result)

	ensure(solve_part2("987654321111111") == 987654321111)
	ensure(solve_part2("811111111111119") == 811111111119)
	ensure(solve_part2("234234234234278") == 434234234278)
	ensure(solve_part2("818181911112111") == 888911112111)

	part2_result: u64 = 0

	start = time.tick_now()
	for line in lines {
		part2_result += solve_part2(line)
	}
	duration = time.tick_since(start);start = time.tick_now()

	fmt.printfln("Part 2 result (in %fms): %d", time.duration_milliseconds(duration), part2_result)
}

