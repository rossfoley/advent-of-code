class Registers
  attr_accessor :registers, :max

  def initialize
    @registers = {}
    @max = -9999
  end

  def get name
    @registers[name] ||= 0
  end

  def inc name, value
    @registers[name] ||= 0
    @registers[name] += value
    @max = [max_register, @max].max
  end

  def max_register
    @registers.values.max
  end
end

class VM
  attr_accessor :registers, :commands

  INSTRUCTION = /(\w+) (inc|dec) (-?\d+) if (\w+) (.+?) (-?\d+)/

  def initialize commands
    @commands = parse commands
    @registers = Registers.new
  end

  def parse commands
    commands.map do |line|
      match = line.match INSTRUCTION
      if match
        {
          inc_reg: match[1],
          inc_val: match[2] == 'inc' ? match[3].to_i : -1 * match[3].to_i,
          cond_reg: match[4],
          operator: match[5],
          cond_val: match[6].to_i
        }
      else
        puts "Can't parse: #{line}"
        return
      end
    end
  end

  def compare left, operator, right
    case operator
    when '>' then left > right
    when '<' then left < right
    when '>=' then left >= right
    when '<=' then left <= right
    when '==' then left == right
    when '!=' then left != right
    else
      puts "Invalid operator: #{operator}"
    end
  end

  def run
    commands.each do |command|
      if compare(registers.get(command[:cond_reg]), command[:operator], command[:cond_val])
        registers.inc(command[:inc_reg], command[:inc_val])
      end
    end
  end
end

class Day08
  def part1 input
    vm = VM.new input
    vm.run
    vm.registers.max_register
  end

  def part2 input
    vm = VM.new input
    vm.run
    vm.registers.max
  end
end

day8 = Day08.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day8.part1(input)
puts "Part 1: #{part1}"

part2 = day8.part2(input)
puts "Part 2: #{part2}"
