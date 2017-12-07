class Day06
  def solve input
    banks = input.strip.split("\t").map(&:to_i)
    seen = []
    latest = ""
    cycles = 0

    while !(seen.include? latest)
      seen << latest

      # Find largest bank
      max = banks.max
      max_index = banks.index max

      # Redistribute that bank's value
      banks[max_index] = 0
      (1..max).each do |i|
        banks[(max_index + i) % banks.size] += 1
      end

      # Store the latest configuration
      latest = banks.join ''
      cycles += 1
    end

    loop_length = cycles - seen.index(latest)
    [cycles, loop_length]
  end
end

day6 = Day06.new
input = File.read('input.txt').lines.first

part1, part2 = day6.solve(input)
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
