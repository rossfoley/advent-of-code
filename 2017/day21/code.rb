class Matrix
  attr_accessor :array

  # Expect data in format like ..#/#.#/###
  def initialize data
    @array = data.split('/').map(&:chars)
  end

  def print
    puts @array.map do |row|
      row.join
    end.join "\n"
  end

  def rotate degrees
    rotations = degrees / 90
    result = @array
    rotations.times { result = result.transpose.map(&:reverse) }
    Matrix.to_s result
  end

  def flip_horizontal
    Matrix.to_s @array.reverse
  end

  def flip_vertical
    Matrix.to_s @array.map(&:reverse)
  end

  def self.to_s data
    data.map(&:join).join '/'
  end

  def self.join strings
    matrices = strings.map {|s| Matrix.new s}
    grid_length = Math.sqrt(matrices.size).to_i
    length = grid_length * matrices[0].size
    (0...length).map do |i|
      
    end
  end
end

class Day21
  def generate_rules input
    rules = {}
    input.each do |line|
      match = line.match /(.+?) => (.+)/
      before, after = match[1], match[2]

      # Add the basic rule
      rules[before] = after

      # Add all flipped and rotated rules
      bm = Matrix.new before
      rules[bm.flip_horizontal] = after
      rules[bm.flip_vertical] = after
      rules[bm.rotate(90)] = after
      rules[bm.rotate(180)] = after
      rules[bm.rotate(270)] = after
    end

    rules
  end

  def part1 input
    rules = generate_rules input
    grid = '.#./..#/###'
    # 5.times do
    #   grid = apply_rules rules, grid
    # end

    grid.count '#'
  end

  def part2 input
  end
end

day21 = Day21.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day21.part1(input)
puts "Part 1: #{part1}"

part2 = day21.part2(input)
puts "Part 2: #{part2}"
