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
				context.logger = {}
				fmt.printfln("%v leaked %d bytes", entry.location, entry.size)
			}

			for entry in tracking_allocator.bad_free_array {
				context.logger = {}
				fmt.printfln("%v bad free on %v", entry.location, entry.memory)
			}

			mem.tracking_allocator_destroy(&tracking_allocator)
		}
	}

	ensure(
		solve_part1({"3-5", "10-14", "16-20", "12-18", "", "1", "5", "8", "11", "17", "32"}) == 3,
	)

	data, err := os.read_entire_file_or_err("input/day05.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day05.txt")

	input := strings.trim_right_space(string(data))
	lines := strings.split_lines(input)
	defer delete(lines)

	start := time.tick_now()
	part1_result := solve_part1(lines)
	duration := time.tick_since(start)

	fmt.printfln("Part 1 result (in %fms): %d", time.duration_milliseconds(duration), part1_result)

	ensure(solve_part2({"3-5", "10-14", "16-20", "12-18"}) == 14)

	start = time.tick_now()
	part2_result := solve_part2(lines)
	duration = time.tick_since(start)

	fmt.printfln("Part 2 result (in %fms): %d", time.duration_milliseconds(duration), part2_result)
}

