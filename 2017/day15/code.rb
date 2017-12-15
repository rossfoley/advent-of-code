class Generator
  attr_accessor :start, :factor

  def initialize start, factor
    @current = start
    @factor = factor
  end

  # Generate the next number
  def generate
    @current = (@current * @factor) % 2147483647
  end

  # Generate the next number that is a multiple of the specified value
  def generate_multiple multiple
    generate
    while @current % multiple != 0
      generate
    end
  end

  # Return the lower 16 bits of the current number
  def lower_bits
    @current & 0b1111111111111111
  end
end

class Day15
  def part1 input
    gen_a = Generator.new input[:a], 16807
    gen_b = Generator.new input[:b], 48271
    matches = 0

    # Count the number of lower 16 bit matches in 40,000,000 iterations
    40000000.times do
      gen_a.generate
      gen_b.generate
      matches += 1 if gen_a.lower_bits == gen_b.lower_bits
    end

    matches
  end

  def part2 input
    gen_a = Generator.new input[:a], 16807
    gen_b = Generator.new input[:b], 48271
    matches = 0

    # Count the number of lower 16 bit matches in 5,000,000 iterations
    # Only consider values that are a multiple of a specific number
    5000000.times do
      gen_a.generate_multiple 4
      gen_b.generate_multiple 8
      matches += 1 if gen_a.lower_bits == gen_b.lower_bits
    end

    matches
  end
end

day15 = Day15.new
input = {a: 699, b: 124}

part1 = day15.part1(input)
puts "Part 1: #{part1}"

part2 = day15.part2(input)
puts "Part 2: #{part2}"
