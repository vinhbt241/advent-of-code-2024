file = File.open("input.txt")

reports = []
file.readlines.each do |line|
  reports << line.chomp.split(' ').map(&:to_i)
end

# ----- PART 1 ------
# count = 0
# reports.each do |report|
#   direction = report[1] - report[0]
#   next if direction.abs > 3 || direction.zero?
#   direction = direction / direction.abs
#   same_direction = true

#   (2...report.length).each do |i|
#     gap = report[i] - report[i - 1]
#     if gap.abs > 3 || gap.zero?
#       same_direction = false
#       break
#     end
#     gap = gap / gap.abs
#     if gap != direction
#       same_direction = false
#       break
#     end
#   end
#   count += 1 if same_direction
# end
# p count

# ----- PART 2 ------
def increasing?(arr, offset)
  (1...arr.length).each do |i|
    sub = arr[i] - arr[i - 1]
    if sub.zero? || sub.negative? || sub.abs > offset
      return false
    end
  end

  return true
end

def decreasing?(arr, offset)
  (1...arr.length).each do |i|
    sub = arr[i] - arr[i - 1]
    if sub.zero? || sub.positive? || sub.abs > offset
      return false
    end
  end

  return true
end

count = 0
reports.each do |report|
  (0...report.size).each do |i|
    arr = report[0...i].concat(report[(i + 1)..-1])
    if increasing?(arr, 3) || decreasing?(arr, 3)
      count += 1
      break
    end
  end
end
p count
