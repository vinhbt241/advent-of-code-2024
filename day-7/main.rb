def valid_equation?(result, nums, current = 0)
  if nums.length.zero?
    return current == result
  end

  valid_equation?(result, nums[1..-1], current + nums.first) ||
  valid_equation?(result, nums[1..-1], current * nums.first) ||
  valid_equation?(result, nums[1..-1], "#{current.zero? ? '' : current}#{nums.first}".to_i)
end

file = File.open("input.txt")

sum = 0
file.readlines.each do |line|
  equation = line.chomp.split(':')
  result = equation.first.to_i
  nums = equation.last.split(' ').compact.map(&:to_i)
  sum += result if valid_equation?(result, nums)
end

p sum