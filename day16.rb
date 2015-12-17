input = File.read('day16-input.txt').lines
sues = []
input.each do |aunt|
  match = aunt.match(/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/)
  sue = {}
  sue[match[2]] = match[3].to_i
  sue[match[4]] = match[5].to_i
  sue[match[6]] = match[7].to_i
  sues << sue
end

correct_sue = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}

sue_result = -1
sues.each_with_index do |sue, i|
  correct = sue.map { |k, v| correct_sue[k.to_sym] == v }.reduce { |a, b| a && b }
  sue_result = i+1 if correct
end
puts "Part 1: Aunt Sue ##{sue_result}"

sue_result = -1
sues.each_with_index do |sue, i|
  correct = sue.map { |k, v|
    if %w(cats trees).include? k
      correct_sue[k.to_sym] < v
    elsif %w(pomeranians goldfish).include? k
      correct_sue[k.to_sym] > v
    else
      correct_sue[k.to_sym] == v
    end
  }.reduce { |a, b| a && b }
  sue_result = i+1 if correct
end

puts "Part 2: Aunt Sue ##{sue_result}"
