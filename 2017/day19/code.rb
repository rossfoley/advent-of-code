class Day19
  # Determine the new direction to go in at a +
  def new_direction grid, row, col, direction
    if (grid[row - 1][col] == '|' && direction != :down)
      :up
    elsif (grid[row + 1][col] == '|' && direction != :up)
      :down
    elsif (grid[row][col - 1] == '-' && direction != :right)
      :left
    elsif (grid[row][col + 1] == '-' && direction != :left)
      :right
    end
  end

  def solve grid
    # Find starting position
    row, col = 0, grid[0].index('|')

    # Always start moving down
    direction = :down

    # Keep track of the letter path and total steps
    letters = []
    steps = 0

    # Grid is surrounded by whitespace, so we end when we hit a space
    while grid[row][col] != ' '
      steps += 1
      char = grid[row][col]

      # Go left/right when we hit a +
      if char == '+'
        direction = new_direction grid, row, col, direction
      elsif char.match /[A-Z]/
        letters << char
      end

      # Move in the current direction
      case direction
      when :up then row -= 1
      when :down then row += 1
      when :left then col -= 1
      when :right then col += 1
      end
    end

    [letters.join, steps]
  end
end

day19 = Day19.new
input = File.read('input.txt').lines

part1, part2 = day19.solve(input)
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
