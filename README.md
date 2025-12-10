# Advent of Code 2025 in Odin

My happiness levels for each solution from 1-5: 🥲, 😬, 😌, 😃, 🤩

|                                               | Part 1                                         | Part 2                                         | Notes                                                                                                                                     |
|:----------------------------------------------|:-----------------------------------------------|:-----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| [Day 01](https://adventofcode.com/2025/day/1) | [part1.odin:     0.235ms](day01/part1.odin) 😃 | [part2.odin:     1.225ms](day01/part2.odin) 😌 | Suprisingly difficult for a day 1. Had some logic error and then just went for brute force for part 2                                     |
| [Day 02](https://adventofcode.com/2025/day/2) | [part1.odin:    71.201ms](day02/part1.odin) 😃 | [part2.odin:    88.099ms](day02/part2.odin) 😃 | Didn't feel like doing a ton of modulo math so i just did the string conversion. I'm running it on 16 threads, lol. It was fun though! :) |
| [Day 03](https://adventofcode.com/2025/day/3) | [part1.odin:     0.104ms](day03/part1.odin) 🤩 | [part2.odin:     0.215ms](day03/part2.odin) 🤩 | Very easy and fun puzzle today!                                                                                                           |
| [Day 04](https://adventofcode.com/2025/day/4) | [part1.odin:     1.315ms](day04/part1.odin) 🤩 | [part2.odin:     2.963ms](day04/part2.odin) 🤩 | Wasn't happy with my initial solution so I rewrote it. I think it turned out pretty nice                                                  |
| [Day 05](https://adventofcode.com/2025/day/5) | [part1.odin:     0.855ms](day05/part1.odin) 🤩 | [part2.odin:     0.365ms](day05/part2.odin) 🤩 | Wanted to use trees at first but it was faster to just sort that shit                                                                     |
| [Day 06](https://adventofcode.com/2025/day/6) | [part1.odin:     3.384ms](day06/part1.odin) 🤩 | [part2.odin:     0.591ms](day06/part2.odin) 🤩 | I used regex for part1 (took me a bit to get right cuz I suck at regex). Part2 was ez                                                     |
| [Day 07](https://adventofcode.com/2025/day/7) | [part1.odin:     0.300ms](day07/part1.odin) 🤩 | [part2.odin:     2.467ms](day07/part2.odin) 🤩 | Had two off by one errors while solving this lol                                                                                          |
| [Day 08](https://adventofcode.com/2025/day/8) | [part1.odin: 14018.089ms](day08/part1.odin) 😬 | [part2.odin: 85224.883ms](day08/part2.odin) 🥲 | Uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh                                                                                                      |
| [Day 09](https://adventofcode.com/2025/day/9) | [part1.odin:     2.796ms](day09/part1.odin) 🤩 | [part2.odin:   864.851ms](day09/part2.odin) 😃 | Finished this on day 10                                                                                                                   |
<!-- | [Day xx](https://adventofcode.com/2025/day/x) | [part1.odin:     0.000ms](dayxx/part1.odin) 🤩 | [part2.odin:  0.000ms](dayxx/part2.odin) 🤩 | | -->

## How to run

*NOTE:* You're not allowed to upload your puzzle input to GitHub.
If you clone this repo, create a folder called `input/` at the root and place your `dayxx.txt` files inside.

To run a solution:

```bash
odin run dayxx
```

Do **not** `cd dayxx` first.

To enable the tracking allocator, which detects memory leaks and bad frees:

```bash
odin run dayxx -debug
```

## Note on the runtimes

To measure the speed of each solution, I simply do:

```odin
start := time.tick_now()
partx_result := solve_partx(input)
duration := time.tick_since(start)
```

This is good enough for my purposes and I didn't want to do any sophisticated benchmarking. Also, all of the runtimes come from my Dell Latitude laptop.
