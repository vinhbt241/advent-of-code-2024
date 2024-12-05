rules_file = File.open("rules.txt")
rules = []
rules_file.readlines.each do |line|
  nums = line.split('|').map(&:to_i)
  key = nums.first
  value = nums.last
  if rules[key].nil?
    rules[key] = []
  end
  rules[key] << value
end

# updates_file = File.open("updates.txt")
# updates_file.readlines.each do |line|
#   update = line.split(',').map(&:to_i)
#   right_order = true

#   ((update.size - 1)..0).step(-1).each do |i|
#     element = update[i]
#     ((i + 1)...update.size).each do |j|
#       if !rules[update[j]].nil? && rules[update[j]].include?(element)
#         right_order = false
#         break
#       end
#     end
#     break unless right_order
#   end

#   if right_order
#     p update
#     middle_element = update[update.size / 2]
#     sum += middle_element
#   end
# end

# p sum

def right_order?(rules, update, i)
  element = update[i]
  ((i + 1)...update.size).each do |j|
    if !rules[update[j]].nil? && rules[update[j]].include?(element)
      return false
    end
  end

  return true
end

wrong_order_updates = []
updates_file = File.open("updates.txt")
updates_file.readlines.each do |line|
  update = line.split(',').map(&:to_i)
  right_order = true
  ((update.size - 1)..0).step(-1).each do |i|
    right_order = right_order && right_order?(rules, update, i)
  end

  wrong_order_updates << update unless right_order
end

sum = 0
wrong_order_updates.each do |update|
  pointer = update.size - 1
  while(pointer >= 0)
    if right_order?(rules, update, pointer)
      pointer -= 1
    else
      tmp = update[pointer]
      update[pointer] = update[pointer + 1]
      update[pointer + 1] = tmp
      pointer += 1
    end
  end

  middle_element = update[update.size / 2]
  sum += middle_element
end

p sum