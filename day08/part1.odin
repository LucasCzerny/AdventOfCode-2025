package aoc

import "core:slice"
import "core:sort"

solve_part1 :: proc(input: []string, nr_pairs: int) -> int {
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

	for pair in 0 ..< nr_pairs {
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
	}

	biggest_circuit_sizes: [3]int

	seen := make([]bool, nr_points)
	defer delete(seen)

	for node, i in nodes {
		if seen[i] || len(node.neighbors) == 0 {
			continue
		}

		circuit_size := calculate_circuit_size(nodes, seen, i)
		if circuit_size > biggest_circuit_sizes[0] {
			biggest_circuit_sizes[0] = circuit_size
			sort.bubble_sort(biggest_circuit_sizes[:])
		}
	}

	return biggest_circuit_sizes[0] * biggest_circuit_sizes[1] * biggest_circuit_sizes[2]
}

calculate_circuit_size :: proc(nodes: []Node, seen: []bool, current_node: int) -> int {
	circuit_size := 1
	seen[current_node] = true

	for neighbor in nodes[current_node].neighbors {
		if seen[neighbor] {
			continue
		}

		circuit_size += calculate_circuit_size(nodes, seen, neighbor)
	}

	return circuit_size
}

