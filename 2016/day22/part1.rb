class Node
  attr_accessor :x, :y, :size, :used

  def initialize x, y, size, used
    @x = x
    @y = y
    @size = size
    @used = used
  end

  def available
    @size - @used
  end

  def use_percent
    @used / @size * 100
  end
end

input = File.read('input.txt').lines[2..-1]

nodes = input.map do |line|
  match = line.match /\/dev\/grid\/node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%/
  Node.new match[1].to_i, match[2].to_i, match[3].to_i, match[4].to_i
end

viable_pairs = 0
(0...nodes.length).each do |i|
  node = nodes[i]
  next if node.used == 0

  nodes.each_with_index do |other, j|
    next if j == i
    if other.available >= node.used
      viable_pairs += 1
    end
  end
end

puts "[Part 1] #{viable_pairs} viable pairs"
