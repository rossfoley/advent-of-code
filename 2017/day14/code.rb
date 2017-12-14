# Copied from Day 10's code
class KnotHash
  attr_accessor :list, :position, :skip_size

  def initialize list = (0..255)
    @list = list.to_a
    @position = 0
    @skip_size = 0
  end

  # Apply a single twist to the knot
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

  # Complete the entire twisting process
  # Twist each length 64 times
  # Return the resulting hash
  def twist_lengths input
    lengths = input.chars.map(&:ord) + [17, 31, 73, 47, 23]
    64.times { lengths.each {|l| twist l } }
    hash
  end

  # Compute final hash for KnotHash
  # Each chunk of 16 numbers is XOR'd together
  # and then converted to hex
  def hash
    @list.each_slice(16).map do |sub|
      "%02x" % sub.reduce(:^)
    end.join
  end
end

class Day14
  attr_accessor :grid

  def print_grid
    @grid.each do |row|
      puts row.map {|c| c == 1 ? '#' : '.'}.join
    end
  end

  def to_binary hex
    hex.to_i(16).to_s(2).rjust(128, '0').chars.map(&:to_i)
  end

  def generate_grid input
    (0..127).map do |i|
      knot = KnotHash.new
      hash = knot.twist_lengths "#{input}-#{i}"
      to_binary hash
    end
  end

  def clear_region x, y
    return unless (0..127).include?(x) && (0..127).include?(y)
    return if @grid[x][y] == 0
    @grid[x][y] = 0

    # Clear neighbors
    clear_region x + 1, y
    clear_region x - 1, y
    clear_region x, y + 1
    clear_region x, y - 1
  end

  def part1 input
    @grid ||= generate_grid input

    @grid.map do |row|
      row.reduce(:+)
    end.reduce(:+)
  end

  def part2 input
    @grid ||= generate_grid input

    regions = 0

    (0..127).each do |x|
      (0..127).each do |y|
        if @grid[x][y] == 1
          regions += 1
          clear_region x, y
        end
      end
    end

    regions
  end
end

day14 = Day14.new
input = 'hfdlxzhv'

part1 = day14.part1(input)
puts "Part 1: #{part1}"

part2 = day14.part2(input)
puts "Part 2: #{part2}"
