WIDTH = 101
HEIGHT = 103
TRAVEL_TIME = 100

file = File.open("input.txt")

robots = []
file.readlines.each do |line|
  position, vector = line.chomp.split(' ')
  position_x, position_y = position.split('=').last.split(',').map(&:to_i)
  vector_x, vector_y = vector.split('=').last.split(',').map(&:to_i)
  robots << [position_x, position_y, vector_x, vector_y]
end

# PART 1
# positions = []
# robots.each do |robot|
#   position_x, position_y, vector_x, vector_y = robot

#   distance_x = position_x + vector_x * TRAVEL_TIME
#   new_pos_x = distance_x % WIDTH
#   if new_pos_x < 0
#     new_pos_x = WIDTH + new_pos_x
#   end

#   distance_y = position_y + vector_y * TRAVEL_TIME
#   new_pos_y = distance_y % HEIGHT
#   if new_pos_y < 0
#     new_pos_y = HEIGHT + new_pos_y
#   end

#   positions << [new_pos_x, new_pos_y]
# end

# top_left = 0
# top_right = 0
# bottom_left = 0
# bottom_right = 0
# positions.each do |position|
#   x, y = position
#   if x < WIDTH / 2 && y < HEIGHT / 2
#     top_left += 1
#   end

#   if x < WIDTH / 2 && y > HEIGHT / 2
#     bottom_left += 1
#   end

#   if x > WIDTH / 2 && y < HEIGHT / 2
#     top_right += 1
#   end

#   if x > WIDTH / 2 && y > HEIGHT / 2
#     bottom_right += 1
#   end
# end

# p [top_left, top_right, bottom_left, bottom_right]
# safety_factor = top_left * top_right * bottom_left * bottom_right
# p safety_factor


# PART 2
def ester_egg?(state)
  simulation = []
  HEIGHT.times do
    simulation << Array.new(WIDTH, '.')
  end
  state.each do |pos|
    x, y, _vx, _vy = pos
    simulation[y][x] = '*'
  end

  simulation.each_with_index do |row, i|
    (0..(row.size - 5)).each do |j|
      if row[j..(j + 4)].join == "*****" && i >= 2
        if simulation[i - 1][j..(j + 4)].join == ".***."
          if simulation[i - 2][j..(j + 4)].join == "..*.."
            puts simulation[i - 2].join
            puts simulation[i - 1].join
            puts simulation[i].join

            return true
          end
        end
      end
    end
  end

  return false
end

def update_state(state)
  new_state = []
  state.each do |pos|
    x, y, vx, vy = pos
    x = (x + vx) % WIDTH
    x += WIDTH if x < 0
    y = (y + vy) % HEIGHT
    y += HEIGHT if y < 0
    new_state << [x, y, vx, vy]
  end
  new_state
end

state = robots
seconds = 0

while(true)
  p seconds
  break if ester_egg?(state)
  state = update_state(state)
  seconds += 1
end

p seconds