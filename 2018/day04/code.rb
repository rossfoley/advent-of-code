class Day04
  def part1 input
    schedule = parse_schedule input
    guard_times = run_schedule schedule

    guard_id, most_minutes = guard_times.to_a.max_by {|a| a[1].size}

    common_minute, count = frequent_minute guard_times[guard_id]
    guard_id * common_minute
  end

  def part2 input
    schedule = parse_schedule input
    guard_times = run_schedule schedule
    guard_minutes = guard_times.map do |id, times|
      minute, count = frequent_minute times
      { id: id, minute: minute, count: count }
    end
    frequent_guard = guard_minutes.max_by {|g| g[:count]}
    frequent_guard[:id] * frequent_guard[:minute]
  end

  def parse_schedule input
    input.map do |line|
      match = line.match(/\[(.+?) (.+?)\] (.+)/)
      if match
        {
          date: match[1],
          time: match[2][3..4].to_i,
          datetime: "#{match[1]} #{match[2]}",
          action: match[3]
        }
      else
        puts "Couldn't match #{line}"
      end
    end.sort_by {|a| a[:datetime]}
  end

  def run_schedule schedule
    guard_times = {}
    guard = -1
    sleep_start = -1
    schedule.each do |event|
      if event[:action].match(/Guard #(\d+)/)
        match = event[:action].match(/Guard #(\d+)/)
        guard = match[1].to_i
        guard_times[guard] ||= []
      end

      if event[:action] == 'falls asleep'
        sleep_start = event[:time]
      end

      if event[:action] == 'wakes up'
        guard_times[guard].concat (sleep_start...event[:time]).to_a
      end
    end
    guard_times
  end

  def frequent_minute guard_times
    minute = guard_times.max_by {|i| guard_times.count(i)}
    [minute, guard_times.count(minute)]
  end
end

day04 = Day04.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day04.part1(input)
puts "Part 1: #{part1}"

part2 = day04.part2(input)
puts "Part 2: #{part2}"
