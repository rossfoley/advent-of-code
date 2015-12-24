packages = File.read('day24-input.txt').lines.map(&:to_i)
weight = packages.reduce(:+) / 3

# Part 1
possibilities = packages.combination(6).to_a.reject do |c|
  c.reduce(:+) != weight
end.map do |c|
  [c.size, c.reduce(:*)]
end.sort do |a, b|
  a[1] <=> b[1]
end

puts possibilities.inspect

# Part 2
weight = packages.reduce(:+) / 4
possibilities = packages.combination(5).to_a.reject do |c|
  c.reduce(:+) != weight
end.map do |c|
  [c.size, c.reduce(:*)]
end.sort do |a, b|
  a[1] <=> b[1]
end

puts possibilities.inspect
