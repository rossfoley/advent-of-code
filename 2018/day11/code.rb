class Day11
  def part1 serial
    grid = (1..300).map do |x|
      (1..300).map do |y|
        rack_id = x + 10
        power = rack_id * y
        power += serial
        power *= rack_id
        power = (power % 1000) / 100
        power -= 5
        power
      end
    end

    max_sum = 0
    x_max = -1
    y_max = -1
    (1..300).each do |x|
      (1..300).each do |y|
        sum = square_sum 3, grid, x, y
        if sum > max_sum
          max_sum = sum
          x_max = x
          y_max = y
        end
      end
    end
    {x: x_max, y: y_max, max: max_sum}
  end

  def square_sum width, grid, x, y
    (x...(x+width)).map do |i|
      (y...(y+width)).map do |j|
        value_at grid, i, j
      end.reduce(:+)
    end.reduce(:+)
  end

  def value_at grid, x, y
    return 0 if x < 1 || x > 300
    return 0 if y < 1 || y > 300
    grid[x-1][y-1]
  end

  def part2 serial
    grid = (1..300).map do |x|
      (1..300).map do |y|
        rack_id = x + 10
        power = rack_id * y
        power += serial
        power *= rack_id
        power = (power % 1000) / 100
        power -= 5
        power
      end
    end

    max_sum = 0
    x_max = -1
    y_max = -1
    width_max = -1
    (1..300).each do |width|
      (1..(300-width)).each do |x|
        (1..(300-width)).each do |y|
          sum = square_sum width, grid, x, y
          if sum > max_sum
            max_sum = sum
            x_max = x
            y_max = y
            width_max = width
          end
        end
      end
    end
    {x: x_max, y: y_max, width: width_max, max: max_sum}
  end
end

day11 = Day11.new

puts "Test Results:"
puts "Serial 18: #{day11.part1 18}"
puts "Serial 42: #{day11.part1 42}"

part1 = day11.part1(8772)
puts "Part 1: #{part1}"

part2 = day11.part2(8722)
puts "Part 2: #{part2}"
