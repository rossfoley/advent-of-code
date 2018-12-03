class Day02
  def part1 input
    twos = 0
    threes = 0
    input.each do |line|
      count = letter_count line
      count.map {|c| c[1]}.uniq.each do |c|
        twos += 1 if c == 2
        threes += 1 if c == 3
      end
    end
    twos * threes
  end

  def letter_count str
    str.chars.group_by {|c| c}.map {|k, v| [k, v.size] }
  end

  def part2 input
    (0...input.size).each do |i|
      first = input[i]
      input.each_with_index do |second, j|
        next if i == j
        diff, indices = word_diff first, second
        if diff == 1
          puts "Part 2"
          p [first, second]
          chars = first.chars
          chars.delete_at indices.first
          puts chars.join
        end
      end
    end
  end

  def word_diff first, second
    diff_indices = []
    diff_total = (0...first.size).map do |i|
      if first[i] == second[i]
        0
      else
        diff_indices << i
        1
      end
    end.reduce(:+)
    [diff_total, diff_indices]
  end
end

day02 = Day02.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day02.part1(input)
puts "Part 1: #{part1}"

day02.part2(input)
