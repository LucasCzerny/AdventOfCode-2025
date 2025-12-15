package aoc

import "core:strconv"
import "core:strings"
import "core:text/regex"

Machine :: struct {
	buttons: [][]int,
	joltage: []int, // only used by part 2
}

State :: []bool

Queue :: struct {
	elements:      []State,
	element_count: int,
	first_element: int,
	last_element:  int,
}

create_queue :: proc(initial_size := 10) -> Queue {
	return Queue{elements = make([]State, initial_size)}
}

queue_push :: proc(queue: ^Queue, state: State) {
	if queue.element_count == len(queue.elements) {
		grow_queue(queue)
	}

	queue.last_element += 1
	queue.last_element %= len(queue.elements)

	queue.elements[queue.last_element] = state
	queue.element_count += 1
}

queue_pop :: proc(queue: ^Queue) -> State {
	state := queue.elements[queue.first_element]
	queue.element_count -= 1

	queue.first_element += 1
	queue.first_element %= len(queue.elements)

	return state
}

grow_queue :: proc(queue: ^Queue) {
	new_elements := make([]State, 2 * len(queue.elements))
	for i in queue.first_element ..= queue.last_element {
		new_elements[i] = queue.elements[i]
	}

	delete(queue.elements)
	queue.elements = new_elements
}

parse_line :: proc(line: string) -> (machine: Machine, target_state: State, initial_state: State) {
	parts := strings.split(line, " ")

	target_str := parts[0]
	target_state = make([]bool, len(target_str) - 2)
	initial_state = make([]bool, len(target_str) - 2)

	for i in 1 ..< len(target_str) - 1 {
		if target_str[i] == '#' {
			target_state[i - 1] = true
		}
	}

	machine.buttons = make([][]int, len(parts) - 2)

	for i in 1 ..< len(parts) - 1 {
		it :=
			regex.create_iterator(parts[i], `\d`) or_else panic(
				"Failed to create the match iterator",
			)

		for true {
			capture, _ := regex.match_iterator(&it) or_break

			button := &machine.buttons[i - 1]
			button^ = make([]int, len(capture.groups))

			for group, j in capture.groups {
				button[j] =
					strconv.parse_int(group, 10) or_else panic(
						"Failed to parse \"group\" to an int",
					)
			}
		}
	}

	return machine, target_state, initial_state
}

destroy_machine :: proc(machine: Machine) {
	for button in machine.buttons {
		delete(button)
	}
	delete(machine.buttons)

	if len(machine.joltage) != 0 {
		delete(machine.joltage)
	}
}

