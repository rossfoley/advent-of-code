require 'prime'

class CPU
  attr_reader :registers, :instructions, :pc, :muls

  def initialize instructions
    @registers = {}
    @instructions = parse_instructions instructions
    @pc = 0
    @muls = 0
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
    when 'set'
      @registers[cmd[:args][0]] = parse_value cmd[:args][1]
    when 'sub'
      @registers[cmd[:args][0]] ||= 0
      @registers[cmd[:args][0]] -= parse_value cmd[:args][1]
    when 'mul'
      @registers[cmd[:args][0]] ||= 0
      @registers[cmd[:args][0]] *= parse_value cmd[:args][1]
      @muls += 1
    when 'jnz'
      if parse_value(cmd[:args][0]) != 0
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

class Day23
  def part1 input
    cpu = CPU.new input
    cpu.run
    cpu.muls
  end

  def part2 input
    # The assembly code computes the number of non-primes
    # between 109,900 and 126,900 at intervals of 17
    (0..1000).map do |i|
      b = 109900 + 17 * i
      Prime.prime?(b) ? 0 : 1
    end.reduce(:+)
  end
end

day23 = Day23.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day23.part1(input)
puts "Part 1: #{part1}"

part2 = day23.part2(input)
puts "Part 2: #{part2}"
