file = File.open("input.txt")

# mul_regexp = /mul\((0|[1-9]\d*),\s?(0|[1-9]\d*)\)/
# sum = 0
# file.readlines.each do |line|
#   pairs = line.scan(mul_regexp)
#   pairs.each do |pair|
#     sum += (pair.first.to_i * pair.last.to_i)
#   end
# end
# p sum

arr = []
line = file.readlines.join
allow = true
str = ""
i = 0
while i < line.length
  if (i + 4) < line.length && line[i..(i + 4)] == "don't"
    arr << str
    str = ""
    i += 5
    allow = false
    next
  elsif (i + 1) < line.length && line[i..(i + 1)] == 'do'
    arr << str
    str = ""
    i += 2
    allow = true
    next
  end
  str += line[i] if allow
  i += 1
end

mul_regexp = /mul\((0|[1-9]\d*),\s?(0|[1-9]\d*)\)/
sum = 0
arr.each do |element|
  pairs = element.scan(mul_regexp)
  pairs.each do |pair|
    sum += (pair.first.to_i * pair.last.to_i)
  end
end

p sum