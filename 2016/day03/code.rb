class Day3
  def load_input
    input = File.read('input.txt').lines
    @triangles = input.map do |line|
      match = line.match /(\d+)\s+(\d+)\s+(\d+)/
      match[1..3].map &:to_i
    end
  end

  def possible_count triangles
    triangles.count do |t|
      (t[0] + t[1]) > t[2] && (t[1] + t[2]) > t[0] && (t[0] + t[2]) > t[1]
    end
  end

  def part1
    "Part 1: #{possible_count @triangles}"
  end

  def part2
    triangles = []
    @triangles.each_slice(3) do |slice|
      (0..2).each do |i|
        result = (0..2).map do |j|
          slice[j][i]
        end
        triangles << result
      end
    end

    "Part 2: #{possible_count triangles}"
  end
end

day3 = Day3.new
day3.load_input

puts day3.part1
puts day3.part2
