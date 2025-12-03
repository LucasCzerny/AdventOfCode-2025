package aoc

solve_part1 :: proc(input: string) -> int {
	largest_tens_digit := -1
	largest_tens_digit_index := -1

	for i in 0 ..< len(input) - 1 {
		digit := cast(int)(input[i] - '0')

		if digit > largest_tens_digit {
			largest_tens_digit = digit
			largest_tens_digit_index = i
		}
	}

	largest_ones_digit := -1
	largest_ones_digit_index := -1

	for i in largest_tens_digit_index + 1 ..< len(input) {
		digit := cast(int)(input[i] - '0')

		if digit > largest_ones_digit {
			largest_ones_digit = digit
			largest_ones_digit_index = i
		}
	}

	return largest_tens_digit * 10 + largest_ones_digit
}

