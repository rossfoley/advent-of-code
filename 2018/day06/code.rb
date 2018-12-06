class Day06
  def part1 input
    grid = (0...400).map do
      [0] * 400
    end

    positions = input.each_with_index.map do |line, i|
      x, y = line.split(',').map(&:to_i)
      {id: i + 1, x: x, y: y}
    end

    positions.each_with_index do |position, i|
      x, y = position[:x], position[:y]
      grid[x][y] = position[:id]
    end

    (0...400).each do |x|
      (0...400).each do |y|
        if grid[x][y] == 0
          distances = positions.map do |position|
            manhattan = (position[:x] - x).abs + (position[:y] - y).abs
            [manhattan, position]
          end.sort_by {|a| a[0]}
          if distances[0][0] != distances[1][0]
            grid[x][y] = distances[0][1][:id]
          end
        end
      end
    end

    exclusions = []
    (0...400).each do |i|
      exclusions << grid[0][i]
      exclusions << grid[i][0]
      exclusions << grid[399][i]
      exclusions << grid[i][399]
    end
    exclusions.uniq!

    flat_grid = grid.flatten
    counts = flat_grid.uniq.map do |id|
      [id, flat_grid.count(id)]
    end.sort_by {|c| c[1]}.reverse

    counts.each do |c|
      if !exclusions.include? c[0]
        return c
      end
    end
  end

  def part2 input
    # Real grid is approximately 400 in width and height
    # With 50 positions, each additional x or y adds 50 to the manhattan distance
    # Therefore, the grid is extended by 10,000 / 50 = 200 in each direction
    grid = (0...800).map do
      [0] * 800
    end
    x_off = 200
    y_off = 200

    positions = input.each_with_index.map do |line, i|
      x, y = line.split(',').map(&:to_i)
      {id: i + 1, x: x, y: y}
    end

    (0...800).each do |x|
      (0...800).each do |y|
        real_x = x - x_off
        real_y = y - y_off
        grid[x][y] = positions.map do |position|
            (position[:x] - real_x).abs + (position[:y] - real_y).abs
        end.reduce(:+)
      end
    end

    grid.flatten.select {|a| a < 10000}.size
  end
end

day06 = Day06.new
input = File.read('input.txt').lines

part1 = day06.part1(input)
puts "Part 1: #{part1}"

part2 = day06.part2(input)
puts "Part 2: #{part2}"
