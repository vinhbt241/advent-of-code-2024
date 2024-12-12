file = File.open("input.txt")

array = []
file.readlines.each do |line|
  array << line.chomp.split('')
end

# PART 1
# def calc_area_and_perimeter(array, i, j, visited)
#   area = 0
#   perimeter = 0
#   stack = [[i, j]]
#   char = array[i][j]
#   visited[i][j] = true

#   p "region #{char}"
#   while !stack.empty?
#     row, col = stack.pop
#     area += 1

#     # calculate perimeter
#     # up
#     if row == 0 ||  array[row - 1][col] != char
#       perimeter += 1
#     end

#     # down
#     if row == (array.size - 1) || array[row + 1][col] != char
#       perimeter += 1
#     end

#     # left
#     if col == 0 || array[row][col - 1] != char
#       perimeter += 1
#     end

#     # right
#     if col == (array.first.size - 1) || array[row][col + 1] != char
#       perimeter += 1
#     end

#     # check other region
#     if row > 0 && !visited[row - 1][col] && array[row - 1][col] == char
#       visited[row - 1][col] = true
#       stack << [row - 1, col]
#     end
#     if row < (array.size - 1) && !visited[row + 1][col] && array[row + 1][col] == char
#       visited[row + 1][col] = true
#       stack << [row + 1, col]
#     end
#     if col > 0 && !visited[row][col - 1] && array[row][col - 1] == char
#       visited[row][col - 1] = true
#       stack << [row, col - 1]
#     end
#     if col < (array.first.size - 1) && !visited[row][col + 1] && array[row][col + 1] == char
#       visited[row][col + 1] = true
#       stack << [row, col + 1]
#     end
#   end

#   p "region area: #{area}"
#   p "region perimeter: #{perimeter}"

#   return [area, perimeter]
# end

# visited = []
# rows = array.size
# (0...rows).each do  |i|
#   visited[i] = []
# end

# total_price = 0
# array.each_with_index do |row, i|
#   row.each_with_index do |col, j|
#     next if visited[i][j]

#     area, perimeter = calc_area_and_perimeter(array, i, j, visited)
#     total_price += (area * perimeter)
#   end
# end

# p total_price

# PART 2
def calc_area_and_sides(array, i, j, visited)
  area = 0
  sides = 0
  stack = [[i, j]]
  char = array[i][j]
  visited[i][j] = true

  p "region #{char}"
  while !stack.empty?
    row, col = stack.pop
    area += 1

    # calculate sides
    # top left
    if (row.zero? || array[row - 1][col] != char) && (col.zero? || array [row][col - 1] != char)
      sides += 1
    end
    # top right
    if (row.zero? || array[row - 1][col] != char) && (col == (array.first.size - 1) || array [row][col + 1] != char)
      sides += 1
    end
    # bottom left
    if (row == (array.size - 1) || array[row + 1][col] != char) && (col.zero? || array [row][col - 1] != char)
      sides += 1
    end
    # bottom right
    if (row == (array.size - 1) || array[row + 1][col] != char) && (col == (array.first.size - 1) || array [row][col + 1] != char)
      sides += 1
    end
    # corner top left
    if (row > 0 && col > 0 && array[row - 1][col - 1] != char && array[row - 1][col] == char && array[row][col - 1] == char)
      sides += 1
    end
    # corner top right
    if (row > 0 && col < (array.first.size - 1) && array[row - 1][col + 1] != char && array[row - 1][col] == char && array[row][col + 1] == char)
      sides += 1
    end
    # corner bottom left
    if (row < (array.size - 1) && col > 0 && array[row + 1][col - 1] != char && array[row + 1][col] == char && array[row][col - 1] == char)
      sides += 1
    end
    # corner bottom right
    if (row < (array.size - 1) && col < (array.first.size - 1) && array[row + 1][col + 1] != char && array[row + 1][col] == char && array[row][col + 1] == char)
      sides += 1
    end


    # check other region
    if row > 0 && !visited[row - 1][col] && array[row - 1][col] == char
      visited[row - 1][col] = true
      stack << [row - 1, col]
    end
    if row < (array.size - 1) && !visited[row + 1][col] && array[row + 1][col] == char
      visited[row + 1][col] = true
      stack << [row + 1, col]
    end
    if col > 0 && !visited[row][col - 1] && array[row][col - 1] == char
      visited[row][col - 1] = true
      stack << [row, col - 1]
    end
    if col < (array.first.size - 1) && !visited[row][col + 1] && array[row][col + 1] == char
      visited[row][col + 1] = true
      stack << [row, col + 1]
    end
  end

  p "region area: #{area}"
  p "region side: #{sides}"

  return [area, sides]
end

visited = []
rows = array.size
(0...rows).each do  |i|
  visited[i] = []
end

total_price = 0
array.each_with_index do |row, i|
  row.each_with_index do |col, j|
    next if visited[i][j]

    area, sides = calc_area_and_sides(array, i, j, visited)
    total_price += (area * sides)
  end
end

p total_price