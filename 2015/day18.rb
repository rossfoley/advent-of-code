# Originally from https://github.com/rossfoley/gameoflife
class Life
  def initialize(board, part2 = false)
    @board = board
    @prev = board
    @height = board.length
    @width = board[0].length
    @corners = [[0, 0], [0, 99], [99, 0], [99, 99]]
    @part2 = part2
    if part2
      @corners.each do |corner|
        @board[corner[0]][corner[1]] = 1
        @prev[corner[0]][corner[1]] = 1
      end
    end
  end

  def to_s
    @board.map do |row|
      row.join ' '
    end.join "\n"
  end

  def next
    copy_board_to_prev
    for y in (0...@height)
      for x in (0...@width)
        neighbors = alive_neighbors(x, y)
        alive = alive?(x, y)
        @board[y][x] = new_state neighbors, alive
        if @part2 && @corners.include?([x, y])
          @board[y][x] = 1
        end
      end
    end
  end

  def total_alive
    @board.inject(0) {|sum, row| sum + row.reduce(:+)}
  end

  private

  def new_state neighbors, alive
    if alive
      if neighbors < 2 or neighbors > 3
        0
      else
        1
      end
    else
      if neighbors == 3
        1
      else
        0
      end
    end
  end

  def alive?(x, y)
    @prev[y][x] == 1
  end

  def alive_neighbors(x, y)
    neighbors = [get(x-1, y-1), get(x, y-1), get(x+1, y-1),
                 get(x-1, y),                get(x+1, y),
                 get(x-1, y+1), get(x, y+1), get(x+1, y+1)]
    neighbors.reduce :+
  end

  def get(x, y)
    if x < 0 or x >= @width
      0
    elsif y < 0 or y >= @height
      0
    else
      @prev[y][x]
    end
  end

  def copy_board_to_prev
    @prev = @board.map do |row|
      row.clone
    end.clone
  end
end

input = File.read('day18-input.txt').lines
starting_board = []
input.each do |lines|
  row = []
  lines.chars.each do |char|
    if char == '#'
      row << 1
    elsif char == '.'
      row << 0
    end
  end
  starting_board << row
end
part1 = Life.new(starting_board)
100.times { part1.next }
puts "Lights after 100 steps: #{part1.total_alive}"

input = File.read('day18-input.txt').lines
starting_board = []
input.each do |lines|
  row = []
  lines.chars.each do |char|
    if char == '#'
      row << 1
    elsif char == '.'
      row << 0
    end
  end
  starting_board << row
end
part2 = Life.new(starting_board, true)
100.times { part2.next }
puts "Lights after 100 steps (Part 2): #{part2.total_alive}"
