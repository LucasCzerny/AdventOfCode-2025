package aoc

solve_part2 :: proc(input: []string) -> u64 {
	nr_columns := len(input[0])
	max_digits_per_number := len(input) - 1
	operation_line := len(input) - 1

	sum: u64 = 0

	for column := 0; column < nr_columns; {
		operation := input[operation_line][column]

		result: u64 = 0
		if operation == '*' {
			result = 1
		}

		for column < nr_columns {
			number_chars := make([]byte, max_digits_per_number)
			number: u64 = 0

			for row in 0 ..= operation_line - 1 {
				char := input[row][column]
				if char == ' ' {
					continue
				}

				number *= 10
				number += u64(char - '0')
			}

			delete(number_chars)
			column += 1

			if number == 0 {
				break
			}

			switch operation {
			case '+':
				result += number
			case '*':
				result *= number
			}
		}

		sum += result
	}

	return sum
}

