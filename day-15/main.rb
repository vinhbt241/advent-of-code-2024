file = File.open("input.txt")

puzzle = []
directions = ''

end_puzzle = false
file.readlines.each do |line|
  end_puzzle = true if line.chomp == ""

  unless end_puzzle
    puzzle << line.chomp.split('')
  else
    directions += line.chomp
  end
end
directions = directions.split('')

def print_puzzle(puzzle)
  puzzle.each do |row|
    puts row.join
  end
end

# PART 1
# current_row = 0
# current_col = 0
# puzzle.each_with_index do |row, i|
#   row.each_with_index do |ceil, j|
#     if ceil == "@"
#       current_row = i
#       current_col = j
#     end
#   end
# end

# def move(puzzle, row, col, direction)
#   object_length = 0
#   new_row = row
#   new_col = col
#   if direction == '>'
#     while puzzle[row][col + (object_length + 1)] == 'O'
#       object_length += 1
#     end

#     return [puzzle, new_row, new_col] if puzzle[row][col + (object_length + 1)] == '#'
#     puzzle[row][(col + 1)..(col + object_length + 1)] = puzzle[row][col..(col + object_length)]
#     new_col += 1
#   end

#   if direction == '<'
#     while puzzle[row][col - (object_length + 1)] == 'O'
#       object_length += 1
#     end

#     return [puzzle, new_row, new_col] if puzzle[row][col - (object_length + 1)] == '#'
#     puzzle[row][(col - (object_length + 1))..(col - 1)] = puzzle[row][(col - object_length)..col]
#     new_col -= 1
#   end

#   if direction == '^'
#     while puzzle[row - (object_length + 1)][col] == 'O'
#       object_length += 1
#     end

#     return [puzzle, new_row, new_col] if puzzle[row - (object_length + 1)][col] == '#'
#     ((row - (object_length + 1))..(row - 1)).each do |i|
#       puzzle[i][col] = puzzle[i + 1][col]
#     end
#     new_row -= 1
#   end

#   if direction == 'v'
#     while puzzle[row + (object_length + 1)][col] == 'O'
#       object_length += 1
#     end

#     return [puzzle, new_row, new_col] if puzzle[row + (object_length + 1)][col] == '#'
#     (row + (object_length + 1)).downto(row + 1) do |i|
#       puzzle[i][col] = puzzle[i - 1][col]
#     end
#     new_row += 1
#   end

#   puzzle[row][col] = '.'

#   [puzzle, new_row, new_col]
# end

# directions.each do |direction|
#   puzzle, current_row, current_col = move(puzzle, current_row, current_col, direction)
# end

# print_puzzle(puzzle)

# sum = 0
# puzzle.each_with_index do |row, i|
#   row.each_with_index do |ceil, j|
#     if ceil == 'O'
#       sum += (i * 100 + j)
#     end
#   end
# end

# p sum

# PART 2
puzzle = puzzle.map do |row|
  new_row = []
  row.each do |ceil|
    if ['#', '.'].include?(ceil)
      new_row << ceil
      new_row << ceil
    end

    if ceil == 'O'
      new_row << '['
      new_row << ']'
    end

    if ceil == '@'
      new_row << '@'
      new_row << '.'
    end
  end

  new_row
end

print_puzzle(puzzle)

def move(puzzle, row, col, direction)
  new_row = row
  new_col = col
  if direction == '>'
    object_length = 0
    while ['[', ']'].include?(puzzle[row][col + (object_length + 1)])
      object_length += 1
    end

    return [puzzle, new_row, new_col] if puzzle[row][col + (object_length + 1)] == '#'
    puzzle[row][(col + 1)..(col + object_length + 1)] = puzzle[row][col..(col + object_length)]
    new_col += 1
  end

  if direction == '<'
    object_length = 0
    while ['[', ']'].include?(puzzle[row][col - (object_length + 1)])
      object_length += 1
    end

    return [puzzle, new_row, new_col] if puzzle[row][col - (object_length + 1)] == '#'
    puzzle[row][(col - (object_length + 1))..(col - 1)] = puzzle[row][(col - object_length)..col]
    new_col -= 1
  end

  if direction == '^'
  end

  if direction == 'v'
  end
end