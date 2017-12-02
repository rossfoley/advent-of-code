class Day02
  def input_to_matrix input
    input.map do |line|
      line.strip.split("\t").map(&:to_i)
    end
  end

  def divisible_nums array
    array.each_with_index do |num, i|
      others = array.dup
      others.delete_at i
      divisible = others.find {|a| a % num == 0 || num % a == 0}
      if divisible
        return [num, divisible].sort    
      end
    end
  end

  def part1 input
    matrix = input_to_matrix input
    matrix.map do |array|
      array.max - array.min
    end.reduce(:+)
  end

  def part2 input
    matrix = input_to_matrix input
    matrix.map do |array|
      low, high = divisible_nums array
      high / low
    end.reduce(:+)
  end
end

day2 = Day02.new
input = File.read('input.txt').lines

part1 = day2.part1(input)
puts "Part 1: #{part1}"

part2 = day2.part2(input)
puts "Part 2: #{part2}"
