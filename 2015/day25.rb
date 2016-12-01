row = 2947
column = 3029
n = row + column - 2
iterations = (n * (n + 1)) / 2 + column - 1
result = 20151125
iterations.times do
  result = (result * 252533) % 33554393
end

puts "Value at (#{row}, #{column}): #{result}"
