starting_molecule = File.read('day19-input-start.txt').lines.first
input = File.read('day19-input.txt').lines
new_molecules = []

replacements = input.map do |line|
  match = line.match(/(\w+) => (\w+)/)
  [match[1], match[2]]
end
replacements.each do |replacement|
  before, after = replacement
  starting_molecule.scan(before) do |a|
    i = $~.offset(0)[0]
    new_molecule = starting_molecule.dup
    new_molecule.slice!(i, a.size)
    new_molecule.insert(i, after)
    new_molecules << new_molecule
  end
end

puts "Part 1: #{new_molecules.uniq.size}"

# Part 2
# 274 elements
# 62 Rn/Ar (31 each)
# 8 Ys
# 274 - 62 - 2*8 - 1 = 195
# https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju
