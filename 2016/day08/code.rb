class Screen
  attr_accessor :commands, :screen

  RECT_CMD = /rect (\d+)x(\d+)/
  ROTATE_COLUMN = /rotate column x=(\d+) by (\d+)/
  ROTATE_ROW = /rotate row y=(\d+) by (\d+)/

  def initialize commands
    @commands = parse_commands commands
    @screen = Array.new(6) { Array.new(50, 0) }
  end

  def parse_commands commands
    commands.map do |command|
      if command.match RECT_CMD
        match = command.match RECT_CMD
        {instruction: 'RECT', args: {columns: match[1].to_i, rows: match[2].to_i}}
      elsif command.match ROTATE_COLUMN
        match = command.match ROTATE_COLUMN
        {instruction: 'ROTATE_COLUMN', args: {column: match[1].to_i, size: match[2].to_i}}
      elsif command.match ROTATE_ROW
        match = command.match ROTATE_ROW
        {instruction: 'ROTATE_ROW', args: {row: match[1].to_i, size: match[2].to_i}}
      else
        puts "Error parsing command: #{command}"
      end
    end
  end

  def exec_commands
    @commands.each do |command|
      instruction, args = command[:instruction], command[:args]
      case instruction
      when 'RECT'
        (0...args[:columns]).each do |x|
          (0...args[:rows]).each do |y|
            @screen[y][x] = 1
          end
        end
      when 'ROTATE_COLUMN'
        prev_column = column args[:column]
        (0...6).each do |row|
          new_row = (row + args[:size]) % 6
          @screen[new_row][args[:column]] = prev_column[row]
        end
      when 'ROTATE_ROW'
        prev_row = row args[:row]
        (0...50).each do |column|
          new_column = (column + args[:size]) % 50
          @screen[args[:row]][new_column] = prev_row[column]
        end
      end
    end
  end

  def column i
    @screen.map {|row| row[i]}
  end

  def row i
    @screen[i].dup
  end

  def print_screen
    @screen.each do |row|
      print_row = row.map do |c|
        if c == 1
          '■'
        else
          ' '
        end
      end
      puts print_row.join ''
    end
  end

  def pixel_count
    @screen.map do |row|
      row.reduce(:+)
    end.reduce(:+)
  end
end

test_commands = [
  'rect 3x2',
  'rotate column x=1 by 1',
  'rotate row y=0 by 4',
  'rotate column x=1 by 1'
]

commands = File.read('input.txt').lines
screen = Screen.new commands
screen.exec_commands


puts "Part 1: #{screen.pixel_count}"
puts 'Part 2:'
screen.print_screen
