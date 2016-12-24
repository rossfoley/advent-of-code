require 'digest'

class Maze
  def initialize input
    @grid = parse_input input
  end

  def parse_input input
    input.map do |line|
      line.strip.chars.map do |c|
        case c
        when '#' then :wall
        when '.' then :open
        else c.to_i
        end
      end
    end
  end

  def display
    output = @grid.map do |row|
      row.map do |space|
        case space
        when :wall then '■'
        when :open then ' '
        else space.to_s
        end
      end.join ''
    end.join "\n"
    puts output
  end

  def get x, y
    @grid[y][x]
  end

  def neighbors x, y
    [[1, 0], [-1, 0], [0, 1], [0, -1]].map do |d|
      nx, ny = x + d[0], y + d[1]
      if (0...@grid[0].length).include?(nx) && (0...@grid.length).include?(ny)
        {position: [nx, ny], type: get(nx, ny)}
      else
        nil
      end
    end.compact
  end

  def open_neighbors x, y
    neighbors(x, y).reject {|n| n[:type] == :wall}
  end

  def numbers
    result = []
    @grid.each_with_index do |row, y|
      row.each_with_index do |space, x|
        if space != :wall && space != :open
          result << {number: space, position: [x, y]}
        end
      end
    end
    result.sort_by {|r| r[:number]}
  end
end


class Node
  attr_reader :state, :parent

  def initialize state, parent = nil
    @state = state
    @parent = parent
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

class MazeTraveller
  attr_reader :maze, :distances

  def initialize maze
    @maze = maze
    # Distances precomputed with search_all to save time
    @distances = {
      0 => {1 => 30, 2 => 258, 3 => 56, 4 => 214, 5 => 256, 6 => 106, 7 => 44},
      1 => {0 => 30, 2 => 232, 3 => 30, 4 => 188, 5 => 230, 6 => 80, 7 => 54},
      2 => {0 => 258, 1 => 232, 3 => 218, 4 => 56, 5 => 74, 6 => 212, 7 => 278},
      3 => {0 => 56, 1 => 30, 2 => 218, 4 => 174, 5 => 216, 6 => 66, 7 => 80},
      4 => {0 => 214, 1 => 188, 2 => 56, 3 => 174, 5 => 54, 6 => 168, 7 => 234},
      5 => {0 => 256, 1 => 230, 2 => 74, 3 => 216, 4 => 54, 6 => 210, 7 => 276},
      6 => {0 => 106, 1 => 80, 2 => 212, 3 => 66, 4 => 168, 5 => 210, 7 => 126},
      7 => {0 => 44, 1 => 54, 2 => 278, 3 => 80, 4 => 234, 5 => 276, 6 => 126}
    }
  end

  def search start_state, end_state
    fringe = [Node.new(start_state)]
    explored = []

    while true
      current_node = fringe.shift
      break if current_node.nil?

      next if explored.include? current_node.state
      return current_node if end_state == current_node.state

      maze.open_neighbors(current_node.state[0], current_node.state[1]).each do |successor|
        fringe.push Node.new(successor[:position], current_node)
      end

      explored.push current_node.state
    end
  end

  def search_all
    numbers = maze.numbers
    numbers.each_with_index do |number, i|
      others = numbers[(i+1)..-1]

      others.each do |other|
        @distances[number[:number]] ||= {}
        @distances[other[:number]] ||= {}

        path = search(number[:position], other[:position])
        @distances[number[:number]][other[:number]] = path.steps
        @distances[other[:number]][number[:number]] = path.steps
      end
    end
  end

  def shortest_path
    paths = (1..7).to_a.permutation.map do |path|
      steps = 0
      previous = 0
      path.each do |number|
        steps += @distances[previous][number]
        previous = number
      end
      {path: [0] + path, steps: steps}
    end
    paths.min_by {|p| p[:steps]}
  end

  def shortest_closed_path
    paths = (1..7).to_a.permutation.map do |p|
      path = p + [0]
      steps = 0
      previous = 0
      path.each do |number|
        steps += @distances[previous][number]
        previous = number
      end
      {path: [0] + path, steps: steps}
    end
    paths.min_by {|p| p[:steps]}
  end
end

maze = Maze.new(File.read('input.txt').lines)
traveller = MazeTraveller.new maze

shortest_path = traveller.shortest_path
puts "[Part 1] #{shortest_path[:steps]} for the shortest path: #{shortest_path[:path].join ' - '}"

shortest_closed_path = traveller.shortest_closed_path
puts "[Part 2] #{shortest_closed_path[:steps]} for the shortest path returning to 0: #{shortest_closed_path[:path].join ' - '}"
