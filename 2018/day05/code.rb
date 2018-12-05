class Day05
  def part1 input
    result = react input
    result.size
  end

  def part2 input
    ('a'..'z').map do |char|
      result = react(input.delete(char.upcase).delete(char.downcase))
      result.size
    end.min
  end

  def react input
    result = input.chars
    reacted = true
    while reacted
      reacted = false
      i = 0
      while i < (result.size - 1)
        char1, char2 = result[i], result[i+1]
        if reverse? char1, char2
          reacted = true
          result.delete_at(i+1)
          result.delete_at(i)
        else
          i += 1
        end
      end
    end
    result
  end

  def uppercase? char
    ('A'..'Z').include? char
  end

  def lowercase? char
    ('a'..'z').include? char
  end

  def reverse? char1, char2
    if char1.downcase == char2.downcase
      (lowercase?(char1) && uppercase?(char2)) || (uppercase?(char1) && lowercase?(char2))
    else
      false
    end
  end
end

day05 = Day05.new
input = File.read('input.txt').lines.first.strip

part1 = day05.part1(input)
puts "Part 1: #{part1}"

part2 = day05.part2(input)
puts "Part 2: #{part2}"
