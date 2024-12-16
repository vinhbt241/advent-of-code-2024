WALL = '#'
EMPTY = '.'
START_SYM = 'S'
END_SYM = 'E'
DIRECTIONS = {
  up: [[-1, 0], [0, 1], [0, -1]],
  right: [[0, 1], [1, 0], [-1, 0]],
  down: [[1, 0], [0, -1], [0, 1]],
  left: [[0, -1], [-1, 0], [1, 0]]
}
CLOCKWISE_DIRECTION = {
  up: :right,
  right: :down,
  down: :left,
  left: :up
}
COUNTER_CLOCKWISE_DIRECTION = {
  up: :left,
  right: :up,
  down: :right,
  left: :down
}

def calc_shortest_path(grid, row, col, score, visited, direction)
  if grid[row][col] == END_SYM
    return score
  end
  if grid[row][col] == WALL
    return Float::INFINITY
  end

  if visited[row][col]
    return score
  end

  visited[row][col] = true

  directions = DIRECTIONS[direction]
  straight_dir, clockwise_dir, counter_clockwise_dir = directions
  min_score = Float::INFINITY

  unless visited[row + straight_dir[0]][col + straight_dir[1]]
    direction_score = calc_shortest_path(grid, row + straight_dir[0], col + straight_dir[1], score + 1, visited, direction)
    min_score = [min_score, direction_score].min
  end

  unless visited[row + clockwise_dir[0]][col + clockwise_dir[1]]
    direction_score = calc_shortest_path(grid, row + clockwise_dir[0], col + clockwise_dir[1], score + 1001, visited, CLOCKWISE_DIRECTION[direction])
    min_score = [min_score, direction_score].min
  end

  unless visited[row + counter_clockwise_dir[0]][col + counter_clockwise_dir[1]]
    direction_score = calc_shortest_path(grid, row + counter_clockwise_dir[0], col + counter_clockwise_dir[1], score + 1001, visited, COUNTER_CLOCKWISE_DIRECTION[direction])
    min_score = [min_score, direction_score].min
  end

  visited[row][col] = false

  min_score
end

def print_grid(grid)
  grid.each do |row|
    puts row.join
  end
end

file = File.open("input.txt")
grid = []
file.readlines.each do |line|
  grid << line.chomp.split('')
end
visited = []
grid.size.times do
  visited << Array.new(grid.first.size, false)
end

start_row = grid.size - 2
start_col = 1
min_score = [
  calc_shortest_path(grid, start_row, start_col, 0, visited, :up),
  calc_shortest_path(grid, start_row, start_col, 0, visited, :right)
].min
p min_score