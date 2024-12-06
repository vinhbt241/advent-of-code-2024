file = File.open("input.txt")

array = []
file.readlines.each do |line|
  array << line.chomp.split('')
end

start_array = array.clone.map(&:clone)

current_row = nil
current_col = nil
direction = nil

array.each_with_index do |row, i_row|
  found_guard = false
  row.each_with_index do |ceil, i_col|
    if ceil == '^'
      direction = 'up'
      found_guard = true
      current_row = i_row
      current_col = i_col
      break
    end

    if ceil == '>'
      direction = 'right'
      found_guard = true
      current_row = i_row
      current_col = i_col
      break
    end

    if ceil == '<'
      direction = 'left'
      found_guard = true
      current_row = i_row
      current_col = i_col
      break
    end

    if ceil == 'v'
      direction = 'down'
      found_guard = true
      current_row = i_row
      current_col = i_col
      break
    end
  end

  break if found_guard
end

puts "guard position: [#{current_row}, #{current_col}]"
puts "direction: #{direction}"


def patrol(array, row, col, direction)
  count = 1
  while((0...array.length).include?(row) && (0...array[0].length).include?(col))
    count += 1 if array[row][col] == '.'
    array[row][col] = 'X'

    if direction =='up'
      if row == 0
        break
      elsif array[row - 1][col] == '#'
        direction = 'right'
        col += 1
      else
        row -= 1
      end
      next
    end

    if direction == 'down'
      if row == array.length - 1
        break
      elsif array[row + 1][col] == '#'
        direction = 'left'
        col -= 1
      else
        row += 1
      end
      next
    end

    if direction == 'left'
      if col == 0
        break
      elsif array[row][col - 1] == '#'
        direction = 'up'
        row -= 1
      else
        col -= 1
      end
      next
    end

    if direction == 'right'
      if col == array[0].length - 1
        break
      elsif array[row][col + 1] == '#'
        direction = 'down'
        row += 1
      else
        col += 1
      end
      next
    end
  end

  p count
end

patrol(array, current_row, current_col, direction)

# something wrong with this function, some loop were not recognized
def in_loop?(array, row, col, direction)
  encountered = []

  while((0...array.length).include?(row) && (0...array[0].length).include?(col))
    array[row][col] = 'X'

    if direction =='up'
      if row == 0
        return false
      elsif array[row - 1][col] == '#'
        if encountered[row - 1].nil?
          encountered[row - 1] = []
        end
        if encountered[row - 1][col].nil?
          encountered[row - 1][col] = []
        end
        return true if encountered[row - 1][col].include?(direction)
        encountered[row - 1][col] << direction

        direction = 'right'
        col += 1
      else
        row -= 1
      end
      next
    end

    if direction == 'down'
      if row == array.length - 1
        return false
      elsif array[row + 1][col] == '#'
        if encountered[row + 1].nil?
          encountered[row + 1] = []
        end
        if encountered[row + 1][col].nil?
          encountered[row + 1][col] = []
        end
        return true if encountered[row + 1][col].include?(direction)
        encountered[row + 1][col] << direction

        direction = 'left'
        col -= 1
      else
        row += 1
      end
      next
    end

    if direction == 'left'
      if col == 0
        return false
      elsif array[row][col - 1] == '#'
        if encountered[row].nil?
          encountered[row] = []
        end
        if encountered[row][col - 1].nil?
          encountered[row][col - 1] = []
        end
        return true if encountered[row][col - 1].include?(direction)
        encountered[row][col - 1] << direction

        direction = 'up'
        row -= 1
      else
        col -= 1
      end
      next
    end

    if direction == 'right'
      if col == array[0].length - 1
        return false
      elsif array[row][col + 1] == '#'
        if encountered[row].nil?
          encountered[row] = []
        end
        if encountered[row][col + 1].nil?
          encountered[row][col + 1] = []
        end
        return true if encountered[row][col + 1].include?(direction)
        encountered[row][col + 1] << direction

        direction = 'down'
        row += 1
      else
        col += 1
      end
      next
    end
  end

  return false
end

valid_obstacles = 0
obstacles_array = start_array.clone.map(&:clone)
array.each_with_index do |row, i_row|
  row.each_with_index do |ceil, i_col|
    if ceil == 'X'
      temp_array = start_array.clone.map(&:clone)
      temp_array[i_row][i_col] = '#'
      if in_loop?(temp_array, current_row, current_col, direction)
        valid_obstacles += 1
        obstacles_array[i_row][i_col] = "O"
      end
    end
  end
end

p valid_obstacles
obstacles_array.each do |row|
  puts row.join
end