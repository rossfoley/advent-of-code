class KnotHash
  attr_accessor :list, :position, :skip_size

  def initialize list
    @list = list
    @position = 0
    @skip_size = 0
  end

  def twist length
    # Compute the subset of the list
    sub = (0...length).map do |i|
      @list[(@position + i) % @list.size]
    end

    # Replace the subset with its reverse
    sub.reverse.each_with_index do |el, i|
      @list[(@position + i) % @list.size] = el
    end

    @position = (@position + length + @skip_size) % @list.size
    @skip_size += 1
  end

  # Compute final hash for KnotHash
  # Each chunk of 16 numbers is XOR'd together
  # and then converted to hex
  def hash
    (0...16).map do |ci|
      i0 = 16 * ci
      i1 = 16 * (ci + 1) - 1 
      xor = @list[i0..i1].reduce(:^)
      sprintf("%02x", xor)
    end.join ''
  end
end

class Day10
  def part1 input
    lengths = input.split(',').map(&:to_i)
    knot = KnotHash.new (0..255).to_a

    lengths.each { |length| knot.twist length }

    knot.list[0] * knot.list[1]
  end

  def part2 input
    lengths = input.chars.map(&:ord) + [17, 31, 73, 47, 23]
    knot = KnotHash.new (0..255).to_a

    64.times do
      lengths.each { |length| knot.twist length }
    end

    knot.hash
  end
end

day10 = Day10.new
input = File.read('input.txt').lines.first.strip

part1 = day10.part1(input)
puts "Part 1: #{part1}"

part2 = day10.part2(input)
puts "Part 2: #{part2}"
