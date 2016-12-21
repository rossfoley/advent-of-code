class Scrambler
  SWAP_POSITION = /swap position (\d+) with position (\d+)/
  SWAP_LETTER = /swap letter (\w) with letter (\w)/
  ROTATE_STEPS = /rotate (left|right) (\d+) step/
  ROTATE_LETTER = /rotate based on position of letter (\w)/
  REVERSE = /reverse positions (\d+) through (\d+)/
  MOVE = /move position (\d+) to position (\d+)/

  attr_accessor :input

  def initialize input, commands
    @input = input
    @commands = commands
  end

  def run_commands
    @commands.each do |command|
      if command.match SWAP_POSITION
        match = command.match SWAP_POSITION
        i, j = match[1].to_i, match[2].to_i
        @input[i], @input[j] = @input[j], @input[i]
      elsif command.match SWAP_LETTER
        match = command.match SWAP_LETTER
        i, j = @input.index(match[1]), @input.index(match[2])
        @input[i], @input[j] = @input[j], @input[i]
      elsif command.match ROTATE_STEPS
        match = command.match ROTATE_STEPS
        steps = match[2].to_i
        steps *= -1 if match[1] == 'right'
        @input = @input.chars.rotate(steps).join('')
      elsif command.match ROTATE_LETTER
        match = command.match ROTATE_LETTER
        i = @input.index(match[1])
        steps = i + 1
        steps += 1 if i >= 4
        @input = @input.chars.rotate(-1 * steps).join('')
      elsif command.match REVERSE
        match = command.match REVERSE
        i, j = match[1].to_i, match[2].to_i
        @input[i..j] = @input[i..j].reverse
      elsif command.match MOVE
        match = command.match MOVE
        i, j = match[1].to_i, match[2].to_i
        c = @input.slice! i
        @input.insert j, c
      else
        puts "Error parsing command: #{command}"
      end
    end
    @input
  end
end

test_input = [
  'swap position 4 with position 0',
  'swap letter d with letter b',
  'reverse positions 0 through 4',
  'rotate left 1 step',
  'move position 1 to position 4',
  'move position 3 to position 0',
  'rotate based on position of letter b',
  'rotate based on position of letter d'
]
test_scrambler = Scrambler.new 'abcde', test_input

input = File.read('input.txt').lines
scrambler = Scrambler.new 'abcdefgh', input

puts "[Part 1] #{scrambler.run_commands}"

input = ''
output = ''

# Brute force the solution for part 2
while output != 'fbgdceah'
  input = 'abcdefgh'.chars.shuffle.join
  scrambler.input = input
  output = scrambler.run_commands
end

puts "[Part 2] #{input}"
