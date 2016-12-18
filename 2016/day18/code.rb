class Maze
  TRAP = '^'
  SAFE = '.'

  def initialize first_row
    @rows = [first_row]
  end

  def part1
    generate_rows 40
    @rows.map {|r| r.count SAFE}.reduce(:+)
  end

  def part2
    generate_rows 400000
    @rows.map {|r| r.count SAFE}.reduce(:+)
  end

  def generate_rows size
    while @rows.length < size
      generate_next_row
    end
  end

  def generate_next_row
    previous = @rows.last
    new_row = (0...previous.length).map do |i|
      if is_trap? i, previous
        TRAP
      else
        SAFE
      end
    end.join ''
    @rows << new_row
  end

  def is_trap? i, previous
    padded_previous = ".#{previous}."
    left, center, right = padded_previous[i..(i+2)].chars
    if left == TRAP && center == TRAP && right == SAFE
      true
    elsif left == SAFE && center == TRAP && right == TRAP
      true
    elsif left == TRAP && center == SAFE && right == SAFE
      true
    elsif left == SAFE && center == SAFE && right == TRAP
      true
    else
      false
    end
  end
end

row = File.read('input.txt').lines.first.strip
maze = Maze.new row

puts "[Part 1] #{maze.part1}"
puts "[Part 2] #{maze.part2}"
