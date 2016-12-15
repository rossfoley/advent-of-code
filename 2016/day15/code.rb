class Disc
  def initialize number, positions, start
    @number = number
    @positions = positions
    @start = start
  end

  def position time
    (@start + time) % @positions
  end
end

class Machine
  def initialize discs
    @discs = parse_discs discs
  end

  def parse_discs discs
    discs.map do |disc|
      match = disc.match /Disc #(\d+) has (\d+) positions; at time=0, it is at position (\d+)/
      Disc.new match[1].to_i, match[2].to_i, match[3].to_i
    end
  end

  def add_disc disc
    @discs << disc
  end

  def first_success_time
    time = -1
    success = false

    while !success
      time += 1
      success = success? time
    end

    time
  end

  def success? time
    sum = 0

    @discs.each_with_index do |disc, index|
      sum += disc.position(time + index + 1)
    end

    sum == 0
  end
end

machine = Machine.new(File.read('input.txt').lines)
time = machine.first_success_time

puts "[Part 1] time=#{time} is the first time to receive a capsule"

machine.add_disc Disc.new(7, 11, 0)
time = machine.first_success_time

puts "[Part 2] time=#{time} is the first time to receive a capsule"
