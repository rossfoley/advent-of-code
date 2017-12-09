class Day09
  def solve input
    score = 0
    total_garbage = 0
    depth = 0
    inside_garbage = false
    skip = false

    input.chars.each do |char|
      if inside_garbage
        if skip
          skip = false
          next
        else
          case char
          when '!' then skip = true
          when '>' then inside_garbage = false
          else total_garbage += 1
          end
        end
      else
        case char
        when '{' then depth += 1
        when '<' then inside_garbage = true
        when '}'
          score += depth
          depth -= 1
        end
      end
    end

    [score, total_garbage]
  end
end

day9 = Day09.new
input = File.read('input.txt').lines.first.strip

part1, part2 = day9.solve(input)
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
