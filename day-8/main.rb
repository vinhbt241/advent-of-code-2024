require 'set'

file = File.open("input.txt")

antennas = {}
lines = file.readlines
max_row = lines.size
max_col = -1
game_map = []
lines.each_with_index do |line, row|
  max_col = line.length
  game_map << line.chomp.split('')
  line.chomp.split('').each_with_index do |ch, col|
    if ch != '.'
      if antennas[ch].nil?
        antennas[ch] = []
      end
      antennas[ch] << [row, col]
    end
  end
end

count = 0
presented_antinodes = Set.new

# PART 1
# antennas.keys.each do |key|
#   nodes = antennas[key]
#   next if nodes.size < 2

#   nodes.each_with_index do |node_1, i|
#     nodes[(i + 1)..-1].each do |node_2|
#       antinode_1 = [2 * node_1.first - node_2.first, 2 * node_1.last - node_2.last]
#       antinode_2 = [2 * node_2.first - node_1.first, 2 * node_2.last - node_1.last]

#       if (
#         (antinode_1.first >= 0 && antinode_1.first < max_row) &&
#         (antinode_1.last >= 0 && antinode_1.last < max_col)
#       )
#         unless presented_antinodes.include?(antinode_1)
#           count += 1
#           presented_antinodes.add(antinode_1)
#         end
#       end
#       if (
#         (antinode_2.first >= 0 && antinode_2.first < max_row) &&
#         (antinode_2.last >= 0 && antinode_2.last < max_col)
#       )
#         unless presented_antinodes.include?(antinode_2)
#           count += 1
#           presented_antinodes.add(antinode_2)
#         end
#       end
#     end
#   end
# end

# p presented_antinodes
# p count

# PART 2
antennas.keys.each do |key|
  nodes = antennas[key]
  next if nodes.size < 2

  nodes.each_with_index do |node_1, i|
    unless presented_antinodes.include?(node_1)
      count += 1
      presented_antinodes.add(node_1)
    end
    nodes[(i + 1)..-1].each do |node_2|
      unless presented_antinodes.include?(node_2)
        count += 1
        presented_antinodes.add(node_2)
      end

      prev_node_1 = node_1
      prev_node_2 = node_2
      antinode_1 = [2 * prev_node_1.first - prev_node_2.first, 2 * prev_node_1.last - prev_node_2.last]

      while (
        (antinode_1.first >= 0 && antinode_1.first < max_row) &&
        (antinode_1.last >= 0 && antinode_1.last < max_col)
      )
        unless presented_antinodes.include?(antinode_1)
          count += 1
          presented_antinodes.add(antinode_1)
          game_map[antinode_1.first][antinode_1.last] = '#' if game_map[antinode_1.first][antinode_1.last] == '.'
        end
        prev_node_2 = prev_node_1
        prev_node_1 = antinode_1
        antinode_1 = [2 * prev_node_1.first - prev_node_2.first, 2 * prev_node_1.last - prev_node_2.last]
      end

      prev_node_1 = node_1
      prev_node_2 = node_2
      antinode_2 = [2 * prev_node_2.first - prev_node_1.first, 2 * prev_node_2.last - prev_node_1.last]
      while (
        (antinode_2.first >= 0 && antinode_2.first < max_row) &&
        (antinode_2.last >= 0 && antinode_2.last < max_col)
      )
        unless presented_antinodes.include?(antinode_2)
          count += 1
          presented_antinodes.add(antinode_2)
          game_map[antinode_2.first][antinode_2.last] = '#' if game_map[antinode_2.first][antinode_2.last] == '.'
        end

        prev_node_1 = prev_node_2
        prev_node_2 = antinode_2
        antinode_2 = [2 * prev_node_2.first - prev_node_1.first, 2 * prev_node_2.last - prev_node_1.last]
      end
    end
  end
end



p presented_antinodes
p count

game_map.each do |line|
  puts line.join
end