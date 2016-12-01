# Part 1: Total Wrapping Paper
total = File.read('day2-input.txt').lines.map do |line|
  dimensions = line.split('x').map(&:to_i)
  areas = [2 * dimensions[0] * dimensions[1],
           2 * dimensions[0] * dimensions[2],
           2 * dimensions[1] * dimensions[2]]
  areas.reduce(:+) + (areas.min / 2)
end.reduce(:+)

puts "Total Wrapping Paper: #{total} square feet"


# Part 2: Total Ribbon
total = File.read('day2-input.txt').lines.map do |line|
  dimensions = line.split('x').map(&:to_i).sort
  ribbon_wrap = 2 * (dimensions[0] + dimensions[1])
  ribbon_bow = dimensions.reduce(:*)
  ribbon_wrap + ribbon_bow
end.reduce(:+)

puts "Total Ribbon: #{total} feet"

