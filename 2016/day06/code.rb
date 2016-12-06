input = File.read('input.txt').lines
positions = [''] * 8

positions = (0...8).map do |i|
  input.map { |line| line[i] }.join ''
end

part1 = positions.map do |position|
  groups = position.chars.group_by {|a| a}
  max = groups.max_by {|k, v| v.length}
  max[0]
end.join ''

part2 = positions.map do |position|
  groups = position.chars.group_by {|a| a}
  max = groups.min_by {|k, v| v.length}
  max[0]
end.join ''

puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
