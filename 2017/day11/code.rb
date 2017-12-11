class Day11
  DIRECTIONS = ['n', 'ne', 'se', 's', 'sw', 'nw']
  CANCEL_PAIRS = [['n', 's'], ['ne', 'sw'], ['nw', 'se']]
  HALF_PAIRS = [['se', 'sw'], ['ne', 'nw'], ['n', 'se'], ['ne', 's'], ['nw', 's'], ['n', 'sw']]

  def directions_distance directions
    counts = directions.group_by {|a| a}.map {|a, b| [a, b.size]}.to_h
    DIRECTIONS.each {|d| counts[d] ||= 0}

    # Each pair of directions here cancels each other out
    CANCEL_PAIRS.each do |pair|
      small, large = pair.sort_by {|d| counts[d]}
      counts[large] -= counts[small]
      counts[small] = 0
    end

    # Each pair of directions here results in the average of the two
    # This effectively divides the steps in half
    HALF_PAIRS.each do |pair|
      small, large = pair.sort_by {|d| counts[d]}
      counts[large] -= counts[small]
    end

    counts.values.reduce(:+)
  end

  def part1 input
    directions = input.split(',')
    directions_distance directions
  end

  def part2 input
    directions = input.split(',')
    (0...directions.size).map do |i|
      directions_distance directions[0..i]
    end.max
  end
end

day11 = Day11.new
input = File.read('input.txt').lines.first.strip

part1 = day11.part1(input)
puts "Part 1: #{part1}"

part2 = day11.part2(input)
puts "Part 2: #{part2}"
