# Part 1: String Literals - String Values
strings = File.read('day8-input.txt').lines
string_literals = 0
in_memory = 0

strings.each do |string|
  string = string.strip
  string_literals += string.size
  string.gsub!(/\\x[a-f0-9]{2}/, '~')
  string.gsub!("\\\"", '*')
  string.gsub!("\\\\", '#')
  in_memory += (string.size - 2)
end

puts "Part 1: #{string_literals - in_memory}"

# Part 2: Re-encoded Strings
strings = File.read('day8-input.txt').lines
diff = 0

strings.each do |string|
  string = string.strip
  diff += string.scan('\\').size
  diff += string.scan('"').size
  diff += 2
end

puts "Part 2: #{diff}"
