class Person
  DIRECTIONS = [
    [0, 1],  # North
    [1, 0],  # East
    [0, -1], # South
    [-1, 0], # West
  ]

  def initialize
    @position = [0, 0]
    @facing = 0
    @path = [@position]
  end

  def turn direction
    case direction
    when 'L' then @facing = (@facing - 1) % 4
    when 'R' then @facing = (@facing + 1) % 4
    end
  end

  def move steps
    v = DIRECTIONS[@facing]
    steps.times do
      @position[0] += v[0]
      @position[1] += v[1]
      @path << @position.dup
    end
  end

  def blocks_away
    @position.map(&:abs).reduce(:+)
  end

  def first_duplicate_location
    past = []
    answer = []
    @path.each do |loc|
      if past.include? loc
        answer = loc
        break
      else
        past << loc.dup
      end
    end
    answer
  end

  def info
    "Position: #{@position.join ', '}\nTotal Blocks: #{blocks_away}"
  end
end

input = File.read('input.txt').lines.first
directions = input.split ', '

person = Person.new
directions.each do |direction|
  match = direction.match /([LR])(\d+)/
  person.turn match[1]
  person.move match[2].to_i
end

puts 'Part 1'
puts person.info
puts ''

loc = person.first_duplicate_location
puts 'Part 2'
puts "Position: #{loc.join ', '}"
puts "Total Blocks: #{loc.map(&:abs).reduce(:+)}"
