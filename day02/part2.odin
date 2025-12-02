package aoc

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:sync"
import "core:thread"

solve_part2 :: proc(input: string) -> u64 {
	ranges := strings.split(input, ",")

	threads: [NR_THREADS]^thread.Thread
	thread_index := 0

	sum: u64
	sum_mutex: sync.Mutex

	thread_data := Thread_Data {
		sum       = &sum,
		sum_mutex = &sum_mutex,
	}

	for range in ranges {
		from, to := parse_range(range)

		t := &threads[thread_index]
		if t^ != nil {
			thread.join(t^)
		}

		thread_index = (thread_index + 1) % NR_THREADS

		data := new(Thread_Data)
		data^ = thread_data
		data.from = from
		data.to = to

		t^ = thread.create_and_start_with_data(data, check_range_2)
	}

	for t in threads {
		if t != nil {
			thread.join(t)
		}
	}

	return thread_data.sum^
}

check_range_2 :: proc(thread_data_raw: rawptr) {
	thread_data := cast(^Thread_Data)thread_data_raw
	sum: u64 = 0

	for i in thread_data.from ..= thread_data.to {
		if is_invalid_2(i) {
			sum += u64(i)
		}
	}

	sync.lock(thread_data.sum_mutex)
	thread_data.sum^ += sum
	sync.unlock(thread_data.sum_mutex)
}

is_invalid_2 :: proc(number: i64) -> bool {
	number_buffer: [N]byte
	number_str := strconv.write_int(number_buffer[:], number, 10)

	nr_digits := len(number_str)

	for div in 2 ..= nr_digits {
		if nr_digits % div != 0 {
			continue
		}

		stride := nr_digits / div
		is_repeating := true

		for i in 0 ..< stride {
			should_equal := number_str[i]

			for j in 1 ..< div {
				if number_str[i + j * stride] != should_equal {
					is_repeating = false
					break
				}
			}

			if !is_repeating {
				break
			}
		}

		if is_repeating {
			return true
		}
	}

	return false
}

