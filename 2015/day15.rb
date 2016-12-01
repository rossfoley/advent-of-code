input = File.read('day15-input.txt').lines
ingredients = []
input.each do |line|
  match = line.match(/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/)
  ingredient = {
      capacity: match[2].to_i,
      durability: match[3].to_i,
      flavor: match[4].to_i,
      texture: match[5].to_i,
      calories: match[6].to_i
  }
  ingredients << ingredient
end

TEASPOONS = 100
CALORIES = 500

scores = (0...ingredients.size).to_a.repeated_combination(TEASPOONS).map do |combination|
  capacity   = [combination.map{|a| ingredients[a][:capacity]}.reduce(:+), 0].max
  durability = [combination.map{|a| ingredients[a][:durability]}.reduce(:+), 0].max
  flavor     = [combination.map{|a| ingredients[a][:flavor]}.reduce(:+), 0].max
  texture    = [combination.map{|a| ingredients[a][:texture]}.reduce(:+), 0].max
  calories   = combination.map{|a| ingredients[a][:calories]}.reduce(:+)
  [capacity * durability * flavor * texture, calories]
end

puts "Part 1: #{scores.max_by{|a| a[0]}[0]}"

part2 = scores.reject{|a| a[1] != CALORIES}.max_by{|a| a[0]}[0]
puts "Part 2: #{part2}"
