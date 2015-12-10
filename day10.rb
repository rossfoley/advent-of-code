def look_and_say input
  value = '-1'
  count = 0
  output = ''
  input.chars.each do |char|
    if char == value
      count += 1
    else
      output << "#{count}#{value}" unless value == '-1'
      value = char
      count = 1
    end
  end
  output << "#{count}#{value}"
end

input = '3113322113'

# Part 1: 40 times
40.times { input = look_and_say(input) }
puts "Part 1 (Length): #{input.size}"

# Part 2: 50 times
10.times { input = look_and_say(input) }
puts "Part 2 (Length): #{input.size}"
