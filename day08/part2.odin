package aoc

import "core:slice"
import "core:sort"

solve_part2 :: proc(input: []string) -> uint {
	nr_points := len(input)

	points := make([][3]uint, nr_points)
	nodes := make([]Node, nr_points)
	defer {
		delete(points)
		for node in nodes {
			delete(node.neighbors)
		}
		delete(nodes)
	}

	for line, i in input {
		points[i] = parse_line(line)
		nodes[i] = Node {
			index = i,
		}
	}

	sort.quick_sort_proc(points, compare_points)

	seen := make([]bool, len(nodes))
	defer delete(seen)

	for true {
		min_distance := ~uint(0)
		min_points_indices := [2]int{-1, -1}

		for i in 0 ..< len(points) {
			node := nodes[i]

			for j in i + 1 ..< len(points) {
				if slice.contains(node.neighbors[:], j) {
					continue
				}

				first, second := points[i], points[j]

				distance: uint = 0
				its_joever := false

				for i in 0 ..< 3 {
					distance += squared_distance_single_axis(first[i], second[i])

					if distance >= min_distance {
						its_joever = true
						break
					}
				}

				if !its_joever {
					min_distance = distance
					min_points_indices = {i, j}
				}
			}
		}

		i, j := min_points_indices[0], min_points_indices[1]
		append(&nodes[i].neighbors, j)
		append(&nodes[j].neighbors, i)

		for &value in seen {
			value = false
		}

		mark_nodes_in_circuit(nodes, seen, i)

		done := true
		for &value in seen {
			done &= value
		}

		if done {
			return points[i].x * points[j].x
		}
	}

	return 0
}

mark_nodes_in_circuit :: proc(nodes: []Node, seen: []bool, current_node: int) {
	seen[current_node] = true

	for neighbor in nodes[current_node].neighbors {
		if seen[neighbor] {
			continue
		}

		mark_nodes_in_circuit(nodes, seen, neighbor)
	}
}

