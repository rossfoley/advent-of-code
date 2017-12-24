class Day24
  def form_bridge bridge
    port = bridge.last[0][1]
    options = @components.select do |component|
      component.first == port && !(bridge.map(&:last).include? component)
    end
    reverse_options = @components.select do |component|
      component.last == port && !(bridge.map(&:last).include? component)
    end
    if options.empty? && reverse_options.empty?
      @bridges << bridge
    else
      options.each do |option|
        form_bridge(bridge + [[option, option]])
      end
      reverse_options.each do |option|
        form_bridge(bridge + [[option.reverse, option]])
      end
    end
  end

  def bridge_strength bridge
    bridge.map(&:first).flatten.reduce(:+)
  end

  def print_bridges
    @bridges.each do |bridge|
      puts bridge.map {|b| b.first.join('/')}.join('--')
    end
  end

  def solve input
    @components = input.map {|line| line.split('/').map(&:to_i)}
    @bridges = []

    starts = @components.select {|a, b| a == 0}
    reverse_starts = @components.select {|a, b| b == 0}
    
    starts.each {|s| form_bridge [[s, s]]}
    reverse_starts.each {|s| form_bridge [[s.reverse, s]]}

    part1 = @bridges.map {|b| bridge_strength b}.max

    max_length = @bridges.map(&:size).max
    part2 = @bridges.select {|b| b.size == max_length}.map {|b| bridge_strength b}.max

    [part1, part2]
  end
end

day24 = Day24.new
input = File.read('input.txt').lines.map(&:strip)

part1, part2 = day24.solve(input)
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
