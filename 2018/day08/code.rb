class Day08
  def part1 input
    data = input.split(' ').map(&:to_i)
    i, meta = parse 0, data
    meta.reduce(:+)
  end

  def parse i, data
    child_count = data[i]
    meta_count = data[i + 1]
    i += 2
    meta = []

    (0...child_count).each do |j|
      i, child_meta = parse i, data
      meta += child_meta
    end

    (0...meta_count).each do |j|
      meta << data[i + j]
    end

    i += meta_count
    [i, meta]
  end

  def part2 input
    data = input.split(' ').map(&:to_i)
    i, val = parse_val 0, data
    val
  end

  def parse_val i, data
    child_count = data[i]
    meta_count = data[i + 1]
    i += 2

    children = []
    val = 0

    (0...child_count).each do |j|
      i, child_val = parse_val i, data
      children << child_val
    end

    (0...meta_count).each do |j|
      if child_count == 0
        val += data[i + j]
      else
        child_index = data[i + j] - 1
        next unless child_index < child_count
        val += children[child_index]
      end
    end

    i += meta_count
    [i, val]
  end
end

day08 = Day08.new
input = File.read('input.txt').lines.first.strip

part1 = day08.part1(input)
puts "Part 1: #{part1}"

part2 = day08.part2(input)
puts "Part 2: #{part2}"
