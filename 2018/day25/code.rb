class Day25
  def part1 input
    points = input.map {|a| a.split ','}.map(&:to_i)
    groups = [[points[0]]]
    g_i = 0
    points.delete_at 0
    points.each_with_index do |point, i|
      if distance point 
    end
  end

  def distance p1, p2
    (0...4).map do |i|
      (p1[i] - p2[i]).abs
    end.reduce(:+)
  end

  def part2 input
  end
end

day25 = Day25.new
input = File.read('input.txt').lines

part1 = day25.part1(input)
puts "Part 1: #{part1}"

part2 = day25.part2(input)
puts "Part 2: #{part2}"
