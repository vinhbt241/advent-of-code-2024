file = File.open("input.txt")
line = file.readlines.first
array = line.chomp.split('').map(&:to_i)
id = 0
blocks = []
(0...array.size).step(2).each do |i|
  files = array[i]
  free_spaces = array[i + 1]
  files.times.each do
    blocks << id.to_s
  end
  next if free_spaces.nil?
  free_spaces.times.each do
    blocks << '.'
  end
  id += 1
end

# PART 1
# left = 0
# right = blocks.size - 1
# while(left < right)
#   while blocks[left] != '.'
#     left += 1
#   end
#   while blocks[right] == '.'
#     right -= 1
#   end
#   break if (left >= right)
#   blocks[left] = blocks[right]
#   blocks[right] = '.'
# end

# checksum = 0
# blocks.each_with_index do |num_str, idx|
#   break if num_str == '.'
#   checksum += idx * num_str.to_i
# end

# PART 2
right = blocks.size - 1
while(right >= 0)
  p right
  while right >= 0 && blocks[right] == '.'
    right -= 1
  end

  id = blocks[right]
  file_size = 1
  while right >= 0 && blocks[right - 1] == id
    right -= 1
    file_size += 1
  end

  free_spaces = 0
  (0...right).each do |i|
    if blocks[i] == '.'
      free_spaces += 1
      if free_spaces == file_size
        ((i - free_spaces + 1)..i).each do |j|
          blocks[j] = id
        end
        (right...(right + file_size)).each do |j|
          blocks[j] = '.'
        end
        break
      end
    else
      free_spaces = 0
    end
  end

  right -= 1
end

p blocks.join

checksum = 0
blocks.each_with_index do |num_str, idx|
  next if num_str == '.'
  checksum += idx * num_str.to_i
end

p checksum