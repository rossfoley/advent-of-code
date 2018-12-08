class Day07
  def part1 input
    steps = ('A'..'Z').map {|c| { step: c, reqs: [] }}
    input.each do |line|
      match = line.match(/Step (.) must be finished before step (.) can begin/)
      if match
        add_requirement steps, match[2], match[1]
      else
        puts "Can't match #{line}"
      end
    end

    result = []

    while result.size < steps.size
      steps.each do |step|
        if ready? step, result
          result << step[:step]
          break
        end
      end
    end

    result.join
  end

  def add_requirement steps, step, req
    steps.select {|s| s[:step] == step}.first[:reqs] << req
  end

  def ready? step, completed
    (!completed.include? step[:step]) && step[:reqs].all? {|req| completed.include? req}
  end

  def part2 input
    steps = ('A'..'Z').map {|c| { step: c, reqs: [] }}
    input.each do |line|
      match = line.match(/Step (.) must be finished before step (.) can begin/)
      if match
        add_requirement steps, match[2], match[1]
      else
        puts "Can't match #{line}"
      end
    end

    result = []
    remaining = ('A'..'Z').to_a
    time = 0
    workers = (0...5).map { {step: nil, finished_at: 0} }

    while result.size < steps.size
      unavailable_workers = workers.reject {|w| w[:step].nil?}

      unavailable_workers.each do |worker|
        if worker[:finished_at] <= time
          result << worker[:step]
          worker[:step] = nil
          worker[:finished_at] = 0
        end
      end

      available_workers = workers.select {|w| w[:step].nil?}

      if available_workers.size > 0
        available_workers.each do |worker|
          steps.each do |step|
            if ready?(step, result) && remaining.include?(step[:step])
              worker[:step] = step[:step]
              worker[:finished_at] = time + 61 + (step[:step].ord - 'A'.ord)
              remaining.delete step[:step]
              break
            end
          end
        end
      end

      time += 1
    end

    # Time is off by one at the end
    time - 1
  end
end

day07 = Day07.new
input = File.read('input.txt').lines

part1 = day07.part1(input)
puts "Part 1: #{part1}"

part2 = day07.part2(input)
puts "Part 2: #{part2}"
