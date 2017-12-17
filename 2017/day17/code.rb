class SpinLock
  attr_reader :steps, :next, :buffer

  def initialize steps
    @steps = steps
    @next = 1
    @buffer = [0]
    @index = 0
  end

  def insert_next
    @index = ((@index + @steps) % @buffer.size) + 1
    @buffer.insert @index, @next
    @next += 1
  end

  def after num
    i = @buffer.index num
    @buffer[i + 1]
  end
end
class Day17
  def part1 input
    spinlock = SpinLock.new input
    2017.times { spinlock.insert_next }
    spinlock.after 2017
  end

  def part2 input
    # Takes too long to actually run 50,000,000 iterations
    # 0 always stays at index 0, so just keep track of when position == 0
    after_zero = 0
    position = 0
    (1..50000000).each do |n|
      position = (position + input) % n
      after_zero = n if position == 0
      position += 1
    end
    after_zero
  end
end

day17 = Day17.new
input = 366

part1 = day17.part1(input)
puts "Part 1: #{part1}"

part2 = day17.part2(input)
puts "Part 2: #{part2}"
