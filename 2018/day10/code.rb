class Day10
  def part1 input
    points = []
    input.each do |line|
      values = line.scan(/-?\d+/).map(&:to_i)
      if values
        points << {
          x: values[0],
          y: values[1],
          vx: values[2],
          vy: values[3]
        }
      else
        puts "Can't match: #{line}"
      end
    end
    x_diff = 99999
    y_diff = 99999
    i_min = -1

    # Letters appear when the width and height are minimized
    10081.times do |i|
      tick points
      xs = points.map {|p| p[:x]}
      ys = points.map {|p| p[:y]}
      xd = xs.max - xs.min
      yd = ys.max - ys.min
      x_diff = [x_diff, xd].min
      y_diff = [y_diff, yd].min
      if xd == x_diff || yd == y_diff
        i_min = i
      end
    end

    print_screen points, 9900

    i_min
  end

  def tick points
    points.map! do |point|
      {
        x: point[:x] + point[:vx],
        y: point[:y] + point[:vy],
        vx: point[:vx],
        vy: point[:vy]
      }
    end
  end

  def print_screen points, i
    xs = points.map {|p| p[:x]}
    ys = points.map {|p| p[:y]}

    xmin = xs.min
    xmax = xs.max
    ymin = ys.min
    ymax = ys.max

    pairs = points.map {|p| [p[:x], p[:y]] }

    (ymin..ymax).each do |y|
      (xmin..xmax).each do |x|
        if pairs.include? [x,y]
          print '■'
        else
          print '.'
        end
      end
      print "\n"
    end
  end
end

day10 = Day10.new
input = File.read('input.txt').lines.map(&:strip)

puts "Part 1:"
part1 = day10.part1(input)
# Part 2 is the result from minimizing part 1
puts "Part 2: #{part1 + 1}"
