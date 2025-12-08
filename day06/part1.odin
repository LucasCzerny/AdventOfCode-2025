package aoc

import "core:strconv"
import "core:text/regex"

solve_part1 :: proc(input: []string) -> u64 {
	context.allocator = context.temp_allocator

	number_regex := `\d+`
	operation_regex := `\+|\*`

	operations := make([dynamic]byte)
	defer delete(operations)

	operation_it :=
		regex.create_iterator(input[len(input) - 1], operation_regex) or_else panic(
			"Failed to create the match iterator",
		)

	for true {
		capture, _, matches_left := regex.match_iterator(&operation_it)
		if !matches_left {
			break
		}

		operation := capture.groups[0][0]
		append(&operations, operation)
	}

	numbers_per_equation := len(input) - 1
	nr_equations := len(operations)

	equations := make([][]u64, nr_equations)

	for &equation in equations {
		equation = make([]u64, numbers_per_equation)
	}

	for row in 0 ..< numbers_per_equation {
		it :=
			regex.create_iterator(
				input[row],
				number_regex,
				permanent_allocator = context.temp_allocator,
			) or_else panic("Failed to create the match iterator")

		for i := 0; true; i += 1 {
			capture, _, matches_left := regex.match_iterator(&it)
			if !matches_left {
				break
			}

			number :=
				strconv.parse_u64(capture.groups[0]) or_else panic("Failed to parse the number")

			equations[i][row] = number
		}
	}

	sum: u64 = 0

	for equation, i in equations {
		operation := operations[i]
		switch operation {
		case '+':
			sum += add_numbers(equation)
		case '*':
			sum += multiply_numbers(equation)
		}
	}

	free_all(context.temp_allocator)

	return sum
}

add_numbers :: proc(numbers: []u64) -> u64 {
	result: u64 = 0

	for number in numbers {
		result += number
	}

	return result
}

multiply_numbers :: proc(numbers: []u64) -> u64 {
	result: u64 = 1

	for number in numbers {
		result *= number
	}

	return result
}

