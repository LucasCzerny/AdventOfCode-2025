package aoc

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"
import "core:time"

main :: proc() {
	when ODIN_DEBUG {
		tracking_allocator: mem.Tracking_Allocator
		mem.tracking_allocator_init(&tracking_allocator, context.allocator)
		context.allocator = mem.tracking_allocator(&tracking_allocator)

		defer {
			for _, entry in tracking_allocator.allocation_map {
				fmt.printfln("%v leaked %d bytes", entry.location, entry.size)
			}

			for entry in tracking_allocator.bad_free_array {
				fmt.printfln("%v bad free on %v", entry.location, entry.memory)
			}

			mem.tracking_allocator_destroy(&tracking_allocator)
		}
	}

	ensure(solve_part1({"7,1", "11,1", "11,7", "9,7", "9,5", "2,5", "2,3", "7,3"}) == 50)

	data, err := os.read_entire_file_or_err("input/day09.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day09.txt")

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	start := time.tick_now()
	part1_result := solve_part1(lines)
	duration := time.tick_since(start)

	fmt.printfln("Part 1 result (in %fms): %d", time.duration_milliseconds(duration), part1_result)

	ensure(solve_part2({"7,1", "11,1", "11,7", "9,7", "9,5", "2,5", "2,3", "7,3"}) == 24)

	start = time.tick_now()
	part2_result := solve_part2(lines)
	duration = time.tick_since(start)

	fmt.printfln("Part 2 result (in %fms): %d", time.duration_milliseconds(duration), part2_result)
}

