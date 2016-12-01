# Part 1: Total Houses
directions = File.read('day3-input.txt').lines[0]
presents = [[0, 0]]
location = [0, 0]

directions.chars.each do |direction|
  case direction
  when '^' then location[1] += 1
  when '>' then location[0] += 1
  when '<' then location[0] -= 1
  when 'v' then location[1] -= 1
  end

  presents << location.clone
end

puts "Houses With Presents: #{presents.uniq.count}"

# Part 2: Total Houses With Robo-Santa
presents2 = [[0, 0]]
# Santa, Robo-Santa
locations = [[0, 0], [0, 0]]

directions.chars.each_with_index do |direction, i|
  current_santa = locations[i % 2]
  # puts "Direction: #{direction}, Current Santa: #{current_santa}"
  case direction
  when '^' then current_santa[1] += 1
  when '>' then current_santa[0] += 1
  when '<' then current_santa[0] -= 1
  when 'v' then current_santa[1] -= 1
  end

  presents2 << current_santa.clone
end

puts "Houses With Presents (Robo-Santa version): #{presents2.uniq.count}"

