package aoc

solve_part1 :: proc(input: string) -> int {
	machine, target_state, initial_state := parse_line(input)
	assert(len(target_state) == len(initial_state))

	forward_queue := create_queue()
	queue_push(&forward_queue, initial_state)

	backward_queue := create_queue()
	queue_push(&backward_queue, initial_state)

	found := false
	for !found {
		forward_state := queue_pop(&forward_queue)
		backward_state := queue_pop(&backward_queue)

		for button in machine.buttons {
			for flip_index in button {
				forward_copy := forward_state
				backward_copy := backward_state

				forward_copy[flip_index] = !forward_copy[flip_index]
				backward_copy[flip_index] = !backward_copy[flip_index]

				queue_push(&forward_queue, forward_copy)
				queue_push(&backward_queue, backward_copy)
			}
		}
	}

	return 0
}

