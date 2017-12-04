class Day04
  def part1 input
    input.map do |line|
      words = line.split(' ').group_by {|a| a}.values
      counts = words.map(&:size)
      invalid = counts.select {|count| count > 1} 
      if invalid.size > 0 then 0 else 1 end
    end.reduce(:+)
  end

  def part2 input
    input.map do |line|
      words = line.split(' ').group_by do |word| 
        word.chars.sort.join 
      end.values
      counts = words.map(&:size)
      invalid = counts.select {|count| count > 1} 
      if invalid.size > 0 then 0 else 1 end
    end.reduce(:+)
  end
end

day4 = Day04.new
input = File.read('input.txt').lines

part1 = day4.part1(input)
puts "Part 1: #{part1}"

part2 = day4.part2(input)
puts "Part 2: #{part2}"
