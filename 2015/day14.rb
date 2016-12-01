TIME = 2503
input = File.read('day14-input.txt').lines
reindeer = {}
input.each do |line|
  match = line.match(/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\./)
  reindeer[match[1]] = {
      speed: match[2].to_i,
      flying: match[3].to_i,
      resting: match[4].to_i
  }
end

# Part 1
distances = {}
reindeer.each do |name, attrs|
  interval = attrs[:flying] + attrs[:resting]
  interval_distance = attrs[:speed] * attrs[:flying]
  distances[name] = (TIME / interval) * interval_distance
  remaining = [1.0, (TIME % interval).to_f / attrs[:flying]].min
  distances[name] += remaining * interval_distance
end
winner = distances.max_by {|_, v| v}
puts "Part 1: #{winner[0]} with #{winner[1].to_i} km"

# Part 2
distances = {}
points = {}
reindeer.keys.each {|k| distances[k] = 0; points[k] = 0}

(0...TIME).each do |second|
  reindeer.each do |name, attrs|
    interval = attrs[:flying] + attrs[:resting]
    time_pos = second % interval
    if time_pos < attrs[:flying]
      distances[name] += attrs[:speed]
    end
  end

  winner = distances.max_by {|_, v| v}[0]
  points[winner] += 1
end

winner = points.max_by {|_, v| v}
puts "Part 2: #{winner[0]} with #{winner[1]} points"
