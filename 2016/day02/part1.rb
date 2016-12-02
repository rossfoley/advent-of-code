class Keypad
  # Keypad Layout:
  # 1 2 3
  # 4 5 6
  # 7 8 9

  def initialize
    @x, @y = 1, 1
  end

  def move direction
    case direction
    when 'U' then @y -= 1
    when 'D' then @y += 1
    when 'L' then @x -= 1
    when 'R' then @x += 1
    end
    clamp
  end

  def button
    3 * @y + @x + 1
  end

  def clamp
    @x = [0, @x, 2].sort[1]
    @y = [0, @y, 2].sort[1]
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

puts "Part 1: #{code.join ''}"
