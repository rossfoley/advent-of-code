class Day03
  def part1 input
    square = Math.sqrt(input).ceil
    square += 1 if square % 2 == 0
    diff = input % square
    
    offset = (diff - (square / 2.0)).floor.abs
    square / 2 + offset
  end

  def part2 input
    # 1000 x 1000 grid, starting with all 0s
    grid = Array.new(1000) {|i| Array.new(1000, 0) }

    # Spiral directions
    directions = [{x: 0, y: 1}, {x: -1, y: 0}, {x: 0, y: -1}, {x: 1, y: 0}]
    di = 0

    # Initialize the first two elements
    x, y = 500, 500
    grid[x][y] = 1
    x += 1
    grid[x][y] = 1
    latest = 1

    # Find the first value larger than the input
    while latest < input
      direction = directions[di]
      nd = directions[(di + 1) % 4]

      if grid[x + nd[:x]][y + nd[:y]] == 0
        # We hit a corner, so change directions
        di = (di + 1) % 4
      else
        # Fill in the next grid square
        x += direction[:x]
        y += direction[:y]
        grid[x][y] = surround_sum(grid, x, y)
        latest = grid[x][y]
      end
    end

    latest
  end

  def surround_sum grid, x, y
    grid[x + 1][y + 1] +
      grid[x + 1][y] +
      grid[x + 1][y - 1] +
      grid[x][y + 1] +
      grid[x][y - 1] +
      grid[x - 1][y + 1] + 
      grid[x - 1][y] + 
      grid[x - 1][y - 1]
  end
end

day3 = Day03.new
input = 277678

part1 = day3.part1(input)
puts "Part 1: #{part1}"

part2 = day3.part2(input)
puts "Part 2: #{part2}"
