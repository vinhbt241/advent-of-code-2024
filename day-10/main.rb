file = File.open("input.txt")

array = []
file.readlines.each do |line, visited|
  array << line.chomp.split('').map(&:to_i)
end

# PART 1
# def count_trail_heads(array, row, col, num, visited)
#   if array[row][col] != num
#     return 0
#   end

#   pos_visited = visited.find do |pos|
#     pos[0] == row && pos[1] == col
#   end

#   return 0 unless pos_visited.nil?

#   visited << [row, col]

#   if num == 9
#     return 1
#   end

#   count = 0
#   if row > 0
#     count += count_trail_heads(array, row - 1, col, num + 1, visited)
#   end
#   if row < (array.size - 1)
#     count += count_trail_heads(array, row + 1, col, num + 1, visited)
#   end
#   if col > 0
#     count += count_trail_heads(array, row, col - 1, num + 1, visited)
#   end
#   if col < (array.first.size - 1)
#     count += count_trail_heads(array, row, col + 1, num + 1, visited)
#   end

#   count
# end

# total_count = 0
# (0...array.size).each do |i|
#   (0...array.first.size).each do |j|
#     visited = []
#     total_count += count_trail_heads(array, i, j, 0, visited)
#   end
# end

# p total_count

# PART 2
def count_distinct_trail_heads(array, row, col, num)
  if array[row][col] != num
    return 0
  end

  if num == 9
    return 1
  end

  count = 0
  if row > 0
    count += count_distinct_trail_heads(array, row - 1, col, num + 1)
  end
  if row < (array.size - 1)
    count += count_distinct_trail_heads(array, row + 1, col, num + 1)
  end
  if col > 0
    count += count_distinct_trail_heads(array, row, col - 1, num + 1)
  end
  if col < (array.first.size - 1)
    count += count_distinct_trail_heads(array, row, col + 1, num + 1)
  end

  count
end

total_count = 0
(0...array.size).each do |i|
  (0...array.first.size).each do |j|
    total_count += count_distinct_trail_heads(array, i, j, 0)
  end
end

p total_count