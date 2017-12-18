class Duet
  attr_reader :registers, :instructions, :pc, :recover, :sound

  def initialize instructions
    @registers = {}
    @instructions = parse_instructions instructions
    @pc = 0
    @recover = -1
    @sound = -1
  end

  def parse_instructions instructions
    instructions.map do |instruction|
      parts = instruction.split ' '
      {instruction: parts[0], args: parts[1..-1]}
    end
  end
  
  def tick
    cmd = @instructions[@pc]
    case cmd[:instruction]
    when 'snd'
      @sound = parse_value cmd[:args][0]
    when 'set'
      @registers[cmd[:args][0]] = parse_value cmd[:args][1]
    when 'add'
      @registers[cmd[:args][0]] ||= 0
      @registers[cmd[:args][0]] += parse_value cmd[:args][1]
    when 'mul'
      @registers[cmd[:args][0]] ||= 0
      @registers[cmd[:args][0]] *= parse_value cmd[:args][1]
    when 'mod'
      @registers[cmd[:args][0]] ||= 0
      @registers[cmd[:args][0]] %= parse_value cmd[:args][1]
    when 'rcv'
      if parse_value(cmd[:args][0]) != 0
        @recover = @sound
      end
    when 'jgz'
      if parse_value(cmd[:args][0]) > 0
        @pc += parse_value(cmd[:args][1]) - 1
      end
    else
      puts "Invalid instruction: #{cmd[:instruction]}"
      return
    end
    @pc += 1
  end

  def run
    tick while @pc < @instructions.size && @pc >= 0
  end

  def parse_value value
    if value.match /[a-z]/
      @registers[value] ||= 0
    else
      value.to_i
    end
  end
end
class Day18
  def part1 input
    duet = Duet.new input
    while duet.recover == -1
      duet.tick
    end
    duet.recover
  end
end

day18 = Day18.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day18.part1(input)
puts "Part 1: #{part1}"
