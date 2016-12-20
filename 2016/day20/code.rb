input = File.read('input.txt').lines

ranges = input.map do |line|
  match = line.match /(\d+)-(\d+)/
  [match[1].to_i, match[2].to_i]
end.sort {|a,b| a[0] <=> b[0]}

upper = 1
first_allowed = nil
allowed = 0

ranges.each do |range|
  if range.first > upper + 1
    first_allowed = upper + 1 unless first_allowed
    allowed += range.first - upper - 1
  end
  upper = [range.last, upper].max
end

allowed += 4294967295 - upper

puts "[Part 1] #{first_allowed} is the first allowed IP address"
puts "[Part 2] #{allowed} IP addresses are allowed"
