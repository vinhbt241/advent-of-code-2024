file = File.open("input.txt")

lines = file.readlines

inputs = []
# PART 1 INPUT
# (0...lines.size).step(4).each do |i|
#   xa = lines[i].match(/X\+(\d+)/).captures.first.to_i
#   ya = lines[i].match(/Y\+(\d+)/).captures.first.to_i
#   xb = lines[i + 1].match(/X\+(\d+)/).captures.first.to_i
#   yb = lines[i + 1].match(/Y\+(\d+)/).captures.first.to_i
#   prize_x = lines[i + 2].match(/X=(\d+)/).captures.first.to_i
#   prize_y = lines[i + 2].match(/Y=(\d+)/).captures.first.to_i
#   inputs << [xa, ya, xb, yb, prize_x, prize_y]
# end

# PART 2 INPUT
(0...lines.size).step(4).each do |i|
  xa = lines[i].match(/X\+(\d+)/).captures.first.to_i
  ya = lines[i].match(/Y\+(\d+)/).captures.first.to_i
  xb = lines[i + 1].match(/X\+(\d+)/).captures.first.to_i
  yb = lines[i + 1].match(/Y\+(\d+)/).captures.first.to_i
  prize_x = lines[i + 2].match(/X=(\d+)/).captures.first.to_i
  prize_y = lines[i + 2].match(/Y=(\d+)/).captures.first.to_i
  inputs << [xa, ya, xb, yb, prize_x + 10000000000000, prize_y + 10000000000000]
end

def calc_total_tokens(curr_x, curr_y, tokens, input)
  xa, ya, xb, yb, prize_x, prize_y = input

  b = (xa * prize_y - ya * prize_x) / (yb * xa - xb * ya)
  a = (prize_x - b * xb) / xa

  if a < 0 || b < 0 || ((a * xa + b * xb) != prize_x) || ((a * ya + b * yb) != prize_y)
    return 0
  end

  a * 3 + b
end

total_tokens = 0
inputs.each do |input|
  p input
  tokens = calc_total_tokens(0, 0, 0, input)
  p tokens
  total_tokens += tokens
end

p total_tokens