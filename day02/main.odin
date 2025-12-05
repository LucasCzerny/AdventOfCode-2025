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

	ensure(solve_part1("11-22") == 33)
	ensure(solve_part1("95-115") == 99)
	ensure(solve_part1("998-1012") == 1010)
	ensure(solve_part1("1188511880-1188511890") == 1188511885)
	ensure(solve_part1("222220-222224") == 222222)
	ensure(solve_part1("1698522-1698528") == 0)
	ensure(solve_part1("446443-446449") == 446446)
	ensure(solve_part1("38593856-38593862") == 38593859)

	data, err := os.read_entire_file_or_err("input/day02.txt")
	defer delete(data)
	ensure(err == {}, "Failed to find input/day02.txt")

	input := strings.trim_right_space(string(data))

	start := time.tick_now()
	part1_result := solve_part1(input)
	duration := time.tick_since(start)

	fmt.printfln("Part 1 result (in %fms): %d", time.duration_milliseconds(duration), part1_result)

	ensure(solve_part2("11-22") == 33)
	ensure(solve_part2("95-115") == 210)
	ensure(solve_part2("998-1012") == 2009)
	ensure(solve_part2("1188511880-1188511890") == 1188511885)
	ensure(solve_part2("222220-222224") == 222222)
	ensure(solve_part2("1698522-1698528") == 0)
	ensure(solve_part2("446443-446449") == 446446)
	ensure(solve_part2("38593856-38593862") == 38593859)
	ensure(solve_part2("565653-565659") == 565656)
	ensure(solve_part2("824824821-824824827") == 824824824)
	ensure(solve_part2("2121212118-2121212124") == 2121212121)

	start = time.tick_now()
	part2_result := solve_part2(input)
	duration = time.tick_since(start)

	fmt.printfln("Part 2 result (in %fms): %d", time.duration_milliseconds(duration), part2_result)
}

