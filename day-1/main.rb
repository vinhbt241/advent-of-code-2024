file = File.open("input.txt")

left = []
right = []

file.readlines.each do |line|
  data = line.chomp.split(' ')
  left << data.first.to_i
  right << data.last.to_i
end

# left.sort!
# right.sort!
# distance = 0
# (0...left.size).each do |i|
#   distance += (left[i] - right[i]).abs
# end

# part 2
freqs = []
right.each do |num|
  freqs[num] = 0 if freqs[num].nil?
  freqs[num] += 1
end

similarity = 0
left.each do |num|
  similarity += num * (freqs[num].nil? ? 0 : freqs[num])
end
p similarity