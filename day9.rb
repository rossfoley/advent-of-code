class TravelingSanta
  def initialize directions
    @distances = {}
    @all_locations = []
    directions.each do |direction|
      match = direction.match(/(\w+?) to (\w+?) = (\d+)/)
      @distances[match[1]] ||= {}
      @distances[match[2]] ||= {}
      @distances[match[1]][match[2]] = match[3].to_i
      @distances[match[2]][match[1]] = match[3].to_i
      @all_locations << match[1] unless @all_locations.include? match[1]
      @all_locations << match[2] unless @all_locations.include? match[2]
    end
  end

  def shortest_distance
    @all_locations.map do |location|
      shortest_tsp(location, @all_locations - [location])
    end.min
  end

  def shortest_tsp location, remaining
    return 0 if remaining.empty?
    remaining.map do |next_location|
      shortest_tsp(next_location, remaining - [next_location]) + @distances[location][next_location]
    end.min
  end

  def longest_distance
    @all_locations.map do |location|
      longest_tsp(location, @all_locations - [location])
    end.max
  end

  def longest_tsp location, remaining
    return 0 if remaining.empty?
    remaining.map do |next_location|
      longest_tsp(next_location, remaining - [next_location]) + @distances[location][next_location]
    end.max
  end
end

tsp = TravelingSanta.new(File.read('day9-input.txt').lines)
puts "Shortest Distance: #{tsp.shortest_distance}"
puts "Longest Distance: #{tsp.longest_distance}"
