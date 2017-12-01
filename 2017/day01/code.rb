class Day01
  def self.part1 input
    sum = 0
    chars = input.to_s.chars
    chars.each_with_index do |c, i|
      if c == chars[(i + 1) % chars.size]
        sum += c.to_i
      end
    end
    sum
  end

  def self.part2 input
    sum = 0
    chars = input.to_s.chars
    ahead = chars.size / 2
    chars.each_with_index do |c, i|
      if c == chars[(i + ahead) % chars.size]
        sum += c.to_i
      end
    end
    sum
  end
end

input = File.read('input.txt').lines.first.strip
part1 = Day01.part1(input)
puts "Part 1: #{part1}"

part2 = Day01.part2(input)
puts "Part 2: #{part2}"
