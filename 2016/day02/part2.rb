class Keypad
  LAYOUT = [
    %w(0 0 1 0 0),
    %w(0 2 3 4 0),
    %w(5 6 7 8 9),
    %w(0 A B C 0),
    %w(0 0 D 0 0)
  ]

  def initialize
    @x, @y = 0, 2
  end

  def move direction
    case direction
    when 'U' then try_move @x, @y - 1
    when 'D' then try_move @x, @y + 1
    when 'L' then try_move @x - 1, @y
    when 'R' then try_move @x + 1, @y
    end
  end

  def try_move x, y
    return if x < 0 or x > 4 or y < 0 or y > 4 or LAYOUT[y][x] == '0'
    @x = x
    @y = y
  end

  def button
    LAYOUT[@y][@x]
  end
end


input = File.read('input.txt').lines
keypad = Keypad.new

code = input.map do |line|
  line.chars.each do |direction|
    keypad.move direction
  end
  keypad.button
end

puts "Part 2: #{code.join ''}"
