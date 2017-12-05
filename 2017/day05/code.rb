class Day05
  def part1 input
    jumps = input.map(&:strip).map(&:to_i)
    pc = 0
    steps = 0

    while pc < jumps.size
      jump = jumps[pc]
      jumps[pc] += 1
      pc += jump
      steps += 1
    end
    
    steps
  end

  def part2 input
    jumps = input.map(&:strip).map(&:to_i)
    pc = 0
    steps = 0

    while pc < jumps.size
      jump = jumps[pc]
      if jump >= 3
        jumps[pc] -= 1
      else
        jumps[pc] += 1
      end
      pc += jump
      steps += 1
    end
    
    steps
  end
end

day5 = Day05.new
input = File.read('input.txt').lines

part1 = day5.part1(input)
puts "Part 1: #{part1}"

part2 = day5.part2(input)
puts "Part 2: #{part2}"
