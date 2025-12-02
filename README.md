# Advent of Code 2025 in Odin

My happiness levels for each solution from 1-5: 🥲, 😬, 😌, 😃, 🤩

|                                               | Part 1                                          | Part 2                                          | Notes                                                                                                                                       |
|:----------------------------------------------|:------------------------------------------------|:------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| [Day 01](https://adventofcode.com/2025/day/1) | [part1.odin - 0.387ms](day01/part1.odin) - 😃   | [part2.odin - 1.673ms](day01/part2.odin) - 😌   | Suprisingly difficult for a day 1. Had some logic error and then just went for brute force solution solution for part 2                     |
| [Day 02](https://adventofcode.com/2025/day/1) | [part1.odin - 145.378ms](day02/part1.odin) - 😃 | [part2.odin - 210.508ms](day02/part2.odin) - 😃 | Didn't feel like doing a ton of modulo math so i just did the string conversion. I'm running it on 16 threads, lol. It was fun though! :)   |
<!-- | [Day xx](https://adventofcode.com/2025/day/1) | [part1.odin - xyzms](dayxx/part1.odin) - 🤩     | [part2.odin - xyzms](dayxx/part2.odin) - 🤩     | | -->

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

This is good enough for my purposes and I didn't want to do any sophisticated benchmarking.
