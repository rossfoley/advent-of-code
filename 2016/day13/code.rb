class Node
  attr_reader :state, :parent

  def initialize state, parent = nil, path_cost = 1
    @state = state
    @parent = parent
    @path_cost = path_cost
  end

  def path_cost
    if @parent
      @path_cost + @parent.path_cost
    else
      @path_cost
    end
  end

  def path
    if @parent
      @parent.path << @state
    else
      [@state]
    end
  end

  def steps
    path.size - 1
  end
end

class Maze
  def initialize input
    @input = input
  end

  def start_state
    [1, 1]
  end

  def end_state
    [31, 39]
  end

  def search
    fringe = [Node.new(start_state)]
    explored = []
    
    while true
      current_node = fringe.shift

      next if explored.include? current_node.state
      return current_node if end_state == current_node.state

      successors(current_node.state).each do |state|
        fringe.push Node.new(state, current_node)
      end

      explored.push current_node.state
    end
  end

  def unique_locations steps
    fringe = [Node.new(start_state)]
    solution = []
    
    while fringe.size > 0
      current_node = fringe.shift

      next if current_node.steps > steps
      next if solution.include? current_node.state

      if current_node.steps <= steps
        solution << current_node.state
      end

      successors(current_node.state).each do |state|
        fringe.push Node.new(state, current_node)
      end
    end

    solution
  end

  def successors state
    x, y = state

    # Remove walls and negative locations
    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].reject do |loc|
      is_wall?(loc) || loc.map(&:abs) != loc
    end
  end

  def is_wall? loc
    x, y = loc
    sum = x*x + 3*x + 2*x*y + y + y*y + @input
    ones = sum.to_s(2).chars.count {|c| c == '1'}
    ones % 2 == 1
  end

  def draw path
    width = path.map {|n| n[0]}.max
    height = path.map {|n| n[1]}.max

    (0..height).each do |y|
      row = (0..width).map do |x|
        if [x, y] == start_state
          'S'
        elsif [x, y] == end_state
          'E'
        elsif path.include? [x, y]
          'O'
        elsif is_wall? [x, y]
          '#'
        else
          '.'
        end
      end

      puts row.join ' '
    end
  end
end


maze = Maze.new 1352
solution = maze.search

maze.draw solution.path
puts "[Part 1] #{solution.steps} steps"

locations = maze.unique_locations 50
puts "[Part 2] #{locations.size} unique locations in 50 steps"
