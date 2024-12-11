file = File.open("input.txt")

array = file.readline.chomp.split(' ')

# PART 1
# 25.times do
#   new_array = []
#   array.each do |num|
#     if num.zero?
#       new_array << 1
#     elsif num.to_s.length % 2 == 0
#       num_str = num.to_s
#       first_num = num_str[0...(num_str.length / 2)].to_i
#       second_num = num_str[(num_str.length / 2)..-1].to_i
#       new_array << first_num
#       new_array << second_num
#     else
#       new_array << (num * 2024)
#     end
#   end
#   array = new_array
# end

# p array.length

# PART 2
memoization = {}

array.each do |str|
  if(memoization[str].nil?)
    memoization[str] = 0
  end
  memoization[str] += 1
end

def blink(memo)
  new_memo = {}

  memo.each do |str, count|
    num = str.to_i
    if num.zero?
      inc_memo(new_memo, '1', count)
    elsif str.length.even?
      first_str = str[0...(str.length / 2)]
      second_str = str[(str.length / 2)..-1].to_i.to_s
      inc_memo(new_memo, first_str, count)
      inc_memo(new_memo, second_str, count)
    else
      inc_memo(new_memo, (num * 2024).to_s, count)
    end
  end

  return new_memo
end

def inc_memo(memo, key, count)
  if memo[key].nil?
    memo[key] = 0
  end
  memo[key] += count
end

75.times do
  # p memoization
  memoization = blink(memoization)
end

sum = 0
memoization.each do |k, v|
  sum += v
end

p sum