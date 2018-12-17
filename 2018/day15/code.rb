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

  def first_step
    return unless @parent
    return @state if @parent.parent.nil?
    @parent.first_step
  end
end

class Day15
  def part1 input
    @map = input.map {|l| l.chars}

    # Make a list of all characters on the map
    characters = []
    @map.each_with_index do |row, y|
      row.each_with_index do |val, x|
        if val == 'G'
          characters << {
            type: :goblin,
            hp: 200,
            pos: [x, y]
          }
        elsif val == 'E'
          characters << {
            type: :elf,
            hp: 200,
            pos: [x, y]
          }
        end
      end
    end

    turns = 0
    while characters.map {|c| c[:type]}.count(:elf) > 0
    # 70.times do
      # Sort by reading order
      characters.sort_by! {|c| reading_order c[:pos] }

      characters.each do |c|
        enemy_type = c[:type] == :goblin ? :elf : :goblin
        targets = characters.select {|a| a[:type] == enemy_type} 
        break if targets.empty?

        attacked = attack targets, c
        next if attacked

        options = targets.map {|t| successors t[:pos]}.flatten(1)
        next if options.empty?

        paths = options.map {|o| search c[:pos], o }.compact
        next if paths.empty?

        # Find a path to the nearest target
        path = paths.sort_by {|p| [p.path_cost, reading_order(p.state)]}.first
        old_pos = c[:pos]
        c[:pos] = path.first_step

        # Move to the next spot
        move_on_map old_pos, c[:pos]

        # Try to attack
        attack targets, c

        # Remove dead characters
        characters.reject! do |a|
          if a[:hp] <= 0
            x, y = a[:pos]
            @map[y][x] = '.'
          end
          a[:hp] <= 0
        end
      end

      characters.reject! do |a|
        if a[:hp] <= 0
          x, y = a[:pos]
          @map[y][x] = '.'
        end
        a[:hp] <= 0
      end

      turns += 1
      debug turns, characters
    end

    hp_total = characters.map {|c| c[:hp]}.reduce(:+)
    [hp_total * turns, hp_total, turns]
  end

  def debug turns, characters
    elfs = characters.select {|c| c[:type] == :elf}
    goblins = characters.select {|c| c[:type] == :goblin}
    total_hp = goblins.map {|g| g[:hp]}.reduce(:+)
    puts "Turn #{turns}, #{elfs.size} Elfs, #{goblins.size} Goblins, #{total_hp} HP"
  end

  def move_on_map old_pos, new_pos
    ox, oy = old_pos
    nx, ny = new_pos
    char = @map[oy][ox]
    @map[oy][ox] = '.'
    @map[ny][nx] = char
  end

  def attack targets, c
    attacked = false
    targets.each do |target|
      tx, ty = target[:pos]
      cx, cy = c[:pos]
      distance = (tx - cx).abs + (ty - cy).abs
      if distance == 1
        # In range, so attack
        target[:hp] -= 3
        attacked = true
        break
      end
    end
    attacked
  end

  def reading_order pos
    pos[0] + @map.first.size * pos[1]
  end

  def search start_state, end_state
    fringe = [Node.new(start_state)]
    explored = []
    
    while !fringe.empty?
      current_node = fringe.shift

      next if explored.include? current_node.state
      return current_node if end_state == current_node.state

      successors(current_node.state).each do |state|
        fringe.push Node.new(state, current_node)
      end

      explored.push current_node.state
    end

    # No possible path
    nil
  end

  def successors state
    x, y = state
    options = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
    options.select do |option|
      ox, oy = option
      return false if ox < 0 || ox >= @map.first.size || oy < 0 || oy >= @map.size
      @map[oy][ox] == '.'
    end
  end

  def part2 input
  end
end

day15 = Day15.new
input = File.read('test_input.txt').lines.map(&:strip)

part1 = day15.part1(input)
puts "Part 1: #{part1}"

part2 = day15.part2(input)
puts "Part 2: #{part2}"
