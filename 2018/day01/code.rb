class Day01
  def part1 input
    input.map(&:to_i).reduce {|a, b| a + b}
  end

  def part2 input
    prevSums = [0]
    sum = 0
    searching = true
    while searching 
      input.each do |i|
        sum += i.to_i
        if prevSums.include?(sum)
          searching = false
          break
        end
        prevSums << sum
      end
    end
    sum
  end
end

day1 = Day01.new
input = File.read('input.txt').lines

part1 = day1.part1(input)
puts "Part 1: #{part1}"

part2 = day1.part2(input)
puts "Part 2: #{part2}"
