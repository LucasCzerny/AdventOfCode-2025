package aoc

import "core:math"

solve_part2 :: proc(input: string) -> u64 {
	bank_size := len(input)
	wiggle_room := bank_size - 12

	digits: [12]u8
	start_index := 0

	for digit in 0 ..< 12 {
		largest_digit := input[start_index] - '0'
		largest_digit_index := start_index

		for i in start_index + 1 ..= start_index + wiggle_room {
			digit := input[i] - '0'

			if digit > largest_digit {
				largest_digit = digit
				largest_digit_index = i
			}
		}

		wiggle_room -= (largest_digit_index - start_index)

		start_index = largest_digit_index + 1
		digits[digit] = largest_digit
	}

	result: u64 = 0
	multiplier := cast(u64)math.pow10_f64(11)

	for digit in digits {
		result += u64(digit) * multiplier
		multiplier /= 10
	}

	return result
}

