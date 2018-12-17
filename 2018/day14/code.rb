class Day14
  def part1 input
    scores = [3,7]
    elf1 = 0
    elf2 = 1
    while scores.size < (input + 10)
      sum = scores[elf1] + scores[elf2]
      digits = sum.to_s.chars.map(&:to_i)
      scores.concat digits
      elf1 = (1 + scores[elf1] + elf1) % scores.size
      elf2 = (1 + scores[elf2] + elf2) % scores.size
    end

    scores[-10..-1].join
  end

  def part2 input
    scores = "37"
    input_s = input.to_s
    elf1 = 0
    elf2 = 1
    index = nil

    while index.nil?
      sum = scores[elf1].to_i + scores[elf2].to_i
      scores << sum.to_s
      elf1 = (1 + scores[elf1].to_i + elf1) % scores.size
      elf2 = (1 + scores[elf2].to_i + elf2) % scores.size
      index = scores.index input_s
    end

    index
  end
end

day14 = Day14.new
input = File.read('input.txt').lines.first.to_i

part1 = day14.part1(input)
puts "Part 1: #{part1}"

part2 = day14.part2(input)
puts "Part 2: #{part2}"
