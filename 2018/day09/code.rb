class Day09
  def initialize players, last_marble, debug = false
    @players = players
    @last_marble = last_marble
    @debug = debug
  end

  def part1
    play_game
  end

  def play_game
    @circle = [0]
    @scores = [0] * @players
    current_index = 0
    current_player = 0

    (1..@last_marble).each do |marble|
      if @debug
        p @circle
        p current_index
      end
      if marble % 23 == 0
        @scores[current_player] += marble
        old_index = counter_clockwise current_index, 7
        old_marble = @circle.delete_at old_index
        @scores[current_player] += old_marble
        current_index = old_index
      else
        next_index = clockwise current_index, 2
        @circle.insert next_index, marble
        current_index = next_index
      end

      current_player = (current_player + 1) % @players
    end

    @scores.max
  end

  def clockwise current_index, offset
    sum = current_index + offset
    return sum if sum == @circle.size
    bound current_index + offset
  end

  def counter_clockwise current_index, offset
    bound current_index - offset
  end

  def bound index
    (index + @circle.size) % @circle.size
  end

  def part2
    @last_marble *= 100
    play_game
  end
end

puts 'Test Data'
test_day09 = Day09.new 10, 1618
puts "Test Part 1 (10 players, 1618 last marble): #{test_day09.part1}"

day09 = Day09.new 477, 70851

part1 = day09.part1
puts "Part 1: #{part1}"

part2 = day09.part2
puts "Part 2: #{part2}"
