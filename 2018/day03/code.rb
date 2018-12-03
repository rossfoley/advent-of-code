class Day03
  def part1 input
    claims = parse_input input
    fabric = map_claims claims
    fabric.map do |row|
      row.map do |e|
        if e >= 2
          1
        else
          0
        end
      end.reduce(:+)
    end.reduce(:+)
  end

  def parse_input input
    input.map do |line|
      match = line.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)
      if match
        {
          id: match[1].to_i,
          x: match[2].to_i,
          y: match[3].to_i,
          width: match[4].to_i,
          height: match[5].to_i
        }
      else
        puts "Can't match line #{line}"
      end
    end
  end

  def map_claims claims
    fabric = (0...2000).map { [0] * 2000 }
    claims.each do |claim|
      (claim[:x]...(claim[:x] + claim[:width])).each do |x|
        (claim[:y]...(claim[:y] + claim[:height])).each do |y|
          fabric[x][y] += 1
        end
      end
    end
    fabric
  end

  def part2 input
    claims = parse_input input
    fabric = map_claims claims
    claims.each do |claim|
      only_claim = true
      (claim[:x]...(claim[:x] + claim[:width])).each do |x|
        (claim[:y]...(claim[:y] + claim[:height])).each do |y|
          if fabric[x][y] > 1
            only_claim = false
          end
        end
      end
      return claim[:id] if only_claim
    end
  end
end

day03 = Day03.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day03.part1(input)
puts "Part 1: #{part1}"

part2 = day03.part2(input)
puts "Part 2: #{part2}"
