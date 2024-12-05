array = []

file = File.open("input.txt")

file.readlines.each do |line|
  row = line.chars
  array << row
end

# def word_traced?(array, row, col, word, row_direction, col_direction)
#   if word.length.zero?
#     return true
#   end

#   if row < 0 || row >= array.length || col < 0 || col >= array[0].length
#     return false
#   end

#   first_char = word[0]
#   unless first_char == array[row][col]
#     return false
#   end

#   return word_traced?(array, row + row_direction, col + col_direction, word[1..-1], row_direction, col_direction)
# end

# count = 0
# (0...array.length).each do |row|
#   (0...array[0].length).each do |col|
#     # backward
#     count += 1 if word_traced?(array, row, col, "XMAS", 0, -1)
#     # forward
#     count += 1 if word_traced?(array, row, col, "XMAS", 0, 1)
#     # upward
#     count += 1 if word_traced?(array, row, col, "XMAS", -1, 0)
#     # downward
#     count += 1 if word_traced?(array, row, col, "XMAS", 1, 0)
#     # upper left
#     count += 1 if word_traced?(array, row, col, "XMAS", -1, -1)
#     # upper right
#     count += 1 if word_traced?(array, row, col, "XMAS", -1, 1)
#     # lower left
#     count += 1 if word_traced?(array, row, col, "XMAS", 1, -1)
#     # lower right
#     count += 1 if word_traced?(array, row, col, "XMAS", 1, 1)
#   end
# end

def x_mas?(array, row, col)
  return false if row == 0 || (row == array.length - 1) || col == 0 || col == (array[0].length - 1)
  return false unless array[row][col] == 'A'
  return false unless (array[row - 1][col - 1] == 'M' && array[row + 1][col + 1] == 'S') || (array[row - 1][col - 1] == 'S' && array[row + 1][col + 1] == 'M')
  return false unless (array[row - 1][col + 1] == 'M' && array[row + 1][col - 1] == 'S') || (array[row - 1][col + 1] == 'S' && array[row + 1][col - 1] == 'M')
  return true;
end

count = 0
(0...array.length).each do |row|
  (0...array[0].length).each do |col|
    count += 1 if x_mas?(array, row, col)
  end
end

p count