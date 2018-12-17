class Day12
  def part1 input
    pots = ['.'] * 500
    offset = 250
    rules = {}

    match = input.first.match(/initial state: (.+)/)
    if match
      match[1].chars.each_with_index do |c, i|
        pots[i + offset] = c
      end
    else
      puts "Can't find initial state"
    end

    input[2..-1].each do |line|
      match = line.match(/(.....) => (.)/)
      if match
        rules[match[1]] = match[2]
      else
        puts "Can't match line #{line}"
      end
    end

    20.times do
      new_pots = pots.dup
      pots[2...-2].each_with_index do |pot, i|
        surround = pots[(i-2)..(i+2)].join
        new_pots[i] = rules[surround]
      end
      pots = new_pots
    end

    score pots, offset
  end

  def score pots, offset
    plants = pots.each_with_index.map do |pot, i|
      [pot, i - offset]
    end.select do |a|
      a[0] == '#'
    end

    plants.map {|a| a[1]}.reduce(:+)
  end

  def part2 input
    pots = ['.'] * 10000
    offset = 5000
    rules = {}

    match = input.first.match(/initial state: (.+)/)
    if match
      match[1].chars.each_with_index do |c, i|
        pots[i + offset] = c
      end
    else
      puts "Can't find initial state"
    end

    input[2..-1].each do |line|
      match = line.match(/(.....) => (.)/)
      if match
        rules[match[1]] = match[2]
      else
        puts "Can't match line #{line}"
      end
    end

    # 200.times do |i|
    #   new_pots = pots.dup
    #   pots[2...-2].each_with_index do |pot, i|
    #     surround = pots[(i-2)..(i+2)].join
    #     new_pots[i] = rules[surround]
    #   end
    #   pots = new_pots
    #   puts "Gen #{i}, Score #{score(pots, offset)}"
    # end

    # Score at Generation 200 is 14775, score increases by 81 each generation
    (50000000000 - 200) * 81 + 14775
  end
end

day12 = Day12.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day12.part1(input)
puts "Part 1: #{part1}"

part2 = day12.part2(input)
puts "Part 2: #{part2}"
