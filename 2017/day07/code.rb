class Node
  attr_accessor :name, :weight, :parent, :children

  def initialize name, weight, parent = nil, children = []
    @name = name
    @weight = weight
    @parent = parent
    @children = children
  end

  def add_child child
    @children << child
  end

  def stack_weight
    children_weight = @children.map(&:stack_weight).reduce(:+) || 0
    @weight + children_weight
  end

  def child_weights
    @children.map do |child|
      "#{child.name}: #{child.stack_weight}"
    end
  end
end

class Day07
  def part1 input
    left = []
    right = []
    input.each do |line|
      match = line.strip.match(/(\w+) \(\d+\)(.*)/)
      left << match[1]
      if match[2].size > 2
        right.concat(match[2].strip[3..-1].split(', '))
      end
    end
    (left - right).first
  end

  def part2 input
    root_name = part1 input
    nodes = {}

    # Create all nodes and weights
    input.each do |line|
      match = line.match /(\w+) \((\d+)\)/
      nodes[match[1]] = Node.new match[1], match[2].to_i
    end

    # Create node structure
    input.each do |line|
      match = line.strip.match(/(\w+) \(\d+\) -> (.+)/)
      if match
        root = nodes[match[1]]
        children = match[2].strip.split(', ').map {|name| nodes[name]}
        children.each do |child|
          root.add_child child
          child.parent = root
        end
      end
    end
    
    root_node = nodes[root_name]
    [root_node, nodes]
  end
end

day7 = Day07.new
input = File.read('input.txt').lines

# Result: ahnofa
part1 = day7.part1(input)
puts "Part 1: #{part1}"

# Part 2 solved manually with irb
# Node ltleg should have a weight of 802 instead of 808
# part2 = day7.part2(input)
# puts "Part 2: #{part2}"
