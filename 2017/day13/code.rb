class Layer
  attr_accessor :depth, :range

  def initialize depth, range = 0
    @depth = depth
    @range = range
  end

  def caught? delay = 0
    (@depth + delay) % ((@range - 1) * 2) == 0
  end
end

class Day13
  def generate_layers input
    input.map do |line|
      data = line.split(': ').map(&:to_i)
      Layer.new data[0], data[1]
    end
  end

  def generate_caught layers, delay = 0
    layers.map do |layer|
      layer.caught?(delay) ? layer : nil
    end.compact
  end

  def score layers
    layers.map do |layer|
      layer.depth * layer.range
    end.reduce(:+)
  end

  def part1 input
    layers = generate_layers input
    caught = generate_caught layers
    score caught
  end

  def part2 input
    layers = generate_layers input
    delay = -1
    latest_caught = [0]

    while !latest_caught.empty?
      delay += 1
      latest_caught = generate_caught layers, delay
    end

    delay
  end
end

day13 = Day13.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day13.part1(input)
puts "Part 1: #{part1}"

part2 = day13.part2(input)
puts "Part 2: #{part2}"
