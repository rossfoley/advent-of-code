class State
  attr_accessor :name, :rules

  def initialize name, rules
    @name = name
    @rules = rules
  end
end

class TuringMachine
  attr_accessor :state, :states, :tape, :position

  def initialize start, states
    @state = start
    @states = states
    @tape = Array.new(1_000_000) { 0 }
    @position = 500_000
  end

  def tick
    value = @tape[@position]
    rule = @states[@state].rules[value]

    @tape[@position] = rule[:write]
    @position += rule[:move]
    @state = rule[:new_state]
  end
end

class Day25
  def parse_input input
    input.reject! {|a| a.empty?} # Remove newlines
    input.map! {|a| a[0...-1]} # Strip all periods

    # Get the header data
    start = input.first.split(' ').last
    diagnostic = input[1].split(' ')[-2].to_i
    states = {}

    # All necessary data occurs as the last word on each line
    input.map! {|a| a.split(' ').last}

    # Start after the header
    line = 2
    while line < input.size
      name = input[line]
      rules = {
        0 => {
          write: input[line + 2].to_i,
          move: input[line + 3] == 'left' ? -1 : 1,
          new_state: input[line + 4]
        },
        1 => {
          write: input[line + 6].to_i,
          move: input[line + 7] == 'left' ? -1 : 1,
          new_state: input[line + 8]
        }
      }
      states[name] = State.new name, rules
      line += 9
    end

    [start, diagnostic, states]
  end

  def part1 input
    start, diagnostic, states = parse_input input
    turing = TuringMachine.new start, states

    diagnostic.times { turing.tick }

    turing.tape.reduce(:+)
  end

  def part2 input
  end
end

day25 = Day25.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day25.part1(input)
puts "Part 1: #{part1}"

part2 = day25.part2(input)
puts "Part 2: #{part2}"
