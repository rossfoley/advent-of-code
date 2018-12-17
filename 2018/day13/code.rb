class Day13
  def part1 input
    # Row is Y-axis, Col is X-axis
    
    track = input.map {|l| l.chars }
    carts = []
    track.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if col == '^'
          carts << {
            position: [x, y],
            v: [0, -1],
            ticks: 0
          }
          track[y][x] = '|'
        elsif col == '>'
          carts << {
            position: [x, y],
            v: [1, 0],
            ticks: 0
          }
          track[y][x] = '-'
        elsif col == 'v'
          carts << {
            position: [x, y],
            v: [0, 1],
            ticks: 0
          }
          track[y][x] = '|'
        elsif col == '<'
          carts << {
            position: [x, y],
            v: [-1, 0],
            ticks: 0
          }
          track[y][x] = '-'
        end
      end
    end

    collision = false
    location = nil

    while !collision
      carts.sort_by {|c| c[:position]}.each do |cart|
        x, y = cart[:position]
        xv, yv = cart[:v]
        spot = track[y][x]

        case track[y][x]
        when '\\'
          cart[:v] = [yv, xv]
        when '/'
          cart[:v] = [-yv, -xv]
        when '+'
          case cart[:ticks]
          when 0
            cart[:v] = [yv, -xv]
          when 1 # Straight = do nothing
          when 2
            cart[:v] = [-yv, xv]
          end
          cart[:ticks] = (cart[:ticks] + 1) % 3
        end

        cart[:position] = [x + cart[:v][0], y + cart[:v][1]]
        collision, location = check_collision carts
        break if collision
      end
    end

    location.join ','
  end

  def check_collision carts
    positions = carts.map {|c| c[:position]}
    positions.each do |pos|
      if positions.count(pos) > 1
        return [true, pos]
      end
    end
    [false, nil]
  end

  def part2 input
    # Row is Y-axis, Col is X-axis
    
    track = input.map {|l| l.chars }
    carts = []
    track.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if col == '^'
          carts << {
            position: [x, y],
            v: [0, -1],
            ticks: 0,
            alive: true
          }
          track[y][x] = '|'
        elsif col == '>'
          carts << {
            position: [x, y],
            v: [1, 0],
            ticks: 0,
            alive: true
          }
          track[y][x] = '-'
        elsif col == 'v'
          carts << {
            position: [x, y],
            v: [0, 1],
            ticks: 0,
            alive: true
          }
          track[y][x] = '|'
        elsif col == '<'
          carts << {
            position: [x, y],
            v: [-1, 0],
            ticks: 0,
            alive: true
          }
          track[y][x] = '-'
        end
      end
    end

    collision = false
    location = nil

    while carts.size > 1
      carts.each do |cart|
        next unless cart[:alive]
        x, y = cart[:position]
        xv, yv = cart[:v]
        spot = track[y][x]

        case track[y][x]
        when '\\'
          cart[:v] = [yv, xv]
        when '/'
          cart[:v] = [-yv, -xv]
        when '+'
          case cart[:ticks]
          when 0
            cart[:v] = [yv, -xv]
          when 1 # Straight = do nothing
          when 2
            cart[:v] = [-yv, xv]
          end
          cart[:ticks] = (cart[:ticks] + 1) % 3
        end

        cart[:position] = [x + cart[:v][0], y + cart[:v][1]]
        collision, location = check_collision carts
        if collision
          carts.select {|c| c[:position] == location}.each do |cart|
            cart[:alive] = false
          end
        end
      end

      carts.sort_by! {|c| c[:position]}
      carts.select! {|c| c[:alive]}
    end

    carts.first[:position].join ','
  end
end

day13 = Day13.new
input = File.read('input.txt').lines.map(&:chomp)
test_input = File.read('test_input.txt').lines.map(&:chomp)

puts "Test (should be 7,3)"
test_part1 = day13.part1(test_input)
puts test_part1

part1 = day13.part1(input)
puts "Part 1: #{part1}"

part2 = day13.part2(input)
puts "Part 2: #{part2}"

