def combo_operand(operand, ra, rb, rc)
  return operand.to_i if operand <= 3
  return ra if operand == 4
  return rb if operand == 5
  return rc if operand == 6
end

file = File.open('input.txt')
lines = file.readlines
ra = lines[0].split.last.to_i
rb = lines[1].split.last.to_i
rc = lines[2].split.last.to_i
programs = lines[4].split.last.split(',').map(&:to_i)

# PART 1
outputs = []
pc = 0

while(pc < (programs.size - 1))
  opcode = programs[pc]
  operand = programs[pc + 1]

  if opcode == 0
    ra = (ra.to_f / (2 ** (combo_operand(operand, ra, rb, rc)))).to_i
  end
  if opcode == 1
    rb = rb ^ operand
  end
  if opcode == 2
    rb = combo_operand(operand, ra, rb, rc) % 8
  end
  if opcode == 3 && !ra.zero?
    pc = operand
    next
  end
  if opcode == 4
    rb = (rb ^ rc)
  end
  if opcode == 5
    p [ra, rb, rc]
    outputs << (combo_operand(operand, ra, rb, rc) % 8)
  end
  if opcode == 6
    rb = (ra.to_f / (2 ** (combo_operand(operand, ra, rb, rc)))).to_i
  end
  if opcode == 7
    rc = (ra.to_f / (2 ** (combo_operand(operand, ra, rb, rc)))).to_i
  end

  pc += 2
end

p outputs
puts outputs.map(&:to_s).join(',')

# PART 2
# current_ra = 0
# loop do
#   outputs = []
#   pc = 0
#   ra = current_ra
#   rb = 0
#   rc = 0

#   while(pc < (programs.size - 1))
#     opcode = programs[pc]
#     operand = programs[pc + 1]

#     if opcode == 0
#       ra = (ra.to_f / (2 ** (combo_operand(operand, ra, rb, rc)))).to_i
#     end
#     if opcode == 1
#       rb = rb ^ operand
#     end
#     if opcode == 2
#       rb = combo_operand(operand, ra, rb, rc) % 8
#     end
#     if opcode == 3 && !ra.zero?
#       pc = operand
#       next
#     end
#     if opcode == 4
#       rb = (rb ^ rc)
#     end
#     if opcode == 5
#       outputs << (combo_operand(operand, ra, rb, rc) % 8)
#     end
#     if opcode == 6
#       rb = (ra.to_f / (2 ** (combo_operand(operand, ra, rb, rc)))).to_i
#     end
#     if opcode == 7
#       rc = (ra.to_f / (2 ** (combo_operand(operand, ra, rb, rc)))).to_i
#     end

#     pc += 2
#   end

#   break if outputs.join(',') == programs.join(',')

#   current_ra += 1
#   p current_ra
# end