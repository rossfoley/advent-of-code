TARGET = 29000000
SIZE = TARGET / 10
houses = Array.new(SIZE, 0)

(1..SIZE).each do |n|
  (1..50).each do |i|
    break if n*i >= SIZE
    houses[n*i] += 11 * n
  end
end

first = houses.index {|a| a >= TARGET}
puts "Part 2: #{first}"