class Maze
  TRAP = '^'
  SAFE = '.'

  def initialize first_row
    @first_row = first_row
  end

  def part1
    count_safe 40
  end

  def part2
    count_safe 400000
  end

  def count_safe size
    previous = @first_row
    rows = 1
    count = previous.count SAFE
    while rows < size
      previous = generate_next_row previous
      count += previous.count SAFE
      rows += 1
    end
    count
  end

  def generate_next_row previous
    (0...previous.length).map do |i|
      if is_trap? i, previous
        TRAP
      else
        SAFE
      end
    end.join ''
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
