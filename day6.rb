# Part 1: How Many Lights Are Lit?
instructions = File.read('day6-input.txt').lines
lights = []
for x in 0..999
  lights[x] = [0] * 1000
end

instructions.each do |instruction|
  match = instruction.match(/(.*?)(\d+),(\d+) through (\d+),(\d+)/)
  start_x, end_x = match[2].to_i, match[4].to_i
  start_y, end_y = match[3].to_i, match[5].to_i
  for x in start_x..end_x
    for y in start_y..end_y
      case match[1].strip
      when 'turn on'
        lights[x][y] = 1
      when 'turn off'
        lights[x][y] = 0
      when 'toggle'
        lights[x][y] = (lights[x][y] + 1) % 2
      end
    end
  end
end

lit = 0
for x in 0..999
  for y in 0..999
    lit += lights[x][y]
  end
end

puts "Number of Lights Lit: #{lit}"

# Part 2: How Bright Are The Lights
instructions = File.read('day6-input.txt').lines
lights = []
for x in 0..999
  lights[x] = [0] * 1000
end

instructions.each do |instruction|
  match = instruction.match(/(.*?)(\d+),(\d+) through (\d+),(\d+)/)
  start_x, end_x = match[2].to_i, match[4].to_i
  start_y, end_y = match[3].to_i, match[5].to_i
  for x in start_x..end_x
    for y in start_y..end_y
      case match[1].strip
      when 'turn on'
        lights[x][y] += 1
      when 'turn off'
        lights[x][y] = [lights[x][y] - 1, 0].max
      when 'toggle'
        lights[x][y] += 2
      end
    end
  end
end

brightness = 0
for x in 0..999
  for y in 0..999
    brightness += lights[x][y]
  end
end

puts "Brightness of Lights: #{brightness}"
