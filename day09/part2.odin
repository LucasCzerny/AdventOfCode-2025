package aoc

Point :: [2]int

solve_part2 :: proc(input: []string) -> int {
	nr_points := len(input)

	points := make([]Point, nr_points)
	defer delete(points)

	for i in 0 ..< len(input) {
		point := parse_line(input[i])
		points[i] = point
	}

	max_area := 0

	for first_index in 0 ..< nr_points {
		for second_index in first_index + 1 ..< nr_points {
			first := points[first_index]
			second := points[second_index]

			area := (1 + abs(first.x - second.x)) * (1 + abs(first.y - second.y))

			if area <= max_area {
				continue
			}

			if is_valid_rectangle(first, second, points) {
				max_area = area
			}
		}
	}

	return max_area
}

is_valid_rectangle :: proc(p1, p2: Point, points: []Point) -> bool {
	min_x := min(p1.x, p2.x)
	max_x := max(p1.x, p2.x)
	min_y := min(p1.y, p2.y)
	max_y := max(p1.y, p2.y)

	center_x := f32(min_x + max_x) * 0.5
	center_y := f32(min_y + max_y) * 0.5

	if !is_point_inside_polygon(center_x, center_y, points) {
		return false
	}

	if is_rectangle_interior_clear(min_x, max_x, min_y, max_y, points) {
		return true
	}

	return false
}

is_rectangle_interior_clear :: proc(
	rect_min_x, rect_max_x, rect_min_y, rect_max_y: int,
	points: []Point,
) -> bool {
	n := len(points)

	for first_index in 0 ..< n {
		second_index := (first_index + 1) % n

		border_first := points[first_index]
		border_second := points[second_index]

		is_vertical := border_first.x == border_second.x

		if is_vertical {
			edge_x := border_first.x
			edge_y_min := min(border_first.y, border_second.y)
			edge_y_max := max(border_first.y, border_second.y)

			if edge_x > rect_min_x && edge_x < rect_max_x {
				overlap_start := max(edge_y_min, rect_min_y)
				overlap_end := min(edge_y_max, rect_max_y)

				if overlap_start < overlap_end {
					return false
				}
			}
		} else {
			edge_y := border_first.y
			edge_x_min := min(border_first.x, border_second.x)
			edge_x_max := max(border_first.x, border_second.x)

			if edge_y > rect_min_y && edge_y < rect_max_y {
				overlap_start := max(edge_x_min, rect_min_x)
				overlap_end := min(edge_x_max, rect_max_x)

				if overlap_start < overlap_end {
					return false
				}
			}
		}
	}
	return true
}

is_point_inside_polygon :: proc(point_x, point_y: f32, points: []Point) -> bool {
	inside := false
	n := len(points)

	for i in 0 ..< n {
		j := (i + 1) % n

		p1 := points[i]
		p2 := points[j]

		if (f32(p1.y) <= point_y && point_y < f32(p2.y)) ||
		   (f32(p2.y) <= point_y && point_y < f32(p1.y)) {

			if p1.x == p2.x {
				x_intersect := f32(p1.x)

				if x_intersect > point_x {
					inside = !inside
				}
			}
		}
	}
	return inside
}

is_in_range :: proc(value: int, range: [2]int) -> bool {
	start := min(range[0], range[1])
	end := max(range[0], range[1])
	return start <= value && value <= end
}

