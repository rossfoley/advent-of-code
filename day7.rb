# Part 1: Wire A
class LogicGate
  def initialize instructions, part2 = false
    @wires = {}
    @wire_instructions = {}

    instructions.each do |instruction|
      command, wire = instruction.split(' -> ')
      @wire_instructions[wire[0...-1]] = command
    end

    @wire_instructions['b'] = '46065' if part2

    @assign_value = /^(\d+)$/
    @assign_wire = /^(\w+)$/
    @unary = /^NOT (\w+)$/
    @binary = /^([\w\d]+) ([A-Z]+) ([\w\d]+)$/
  end

  def wire_value wire
    return @wires[wire] if @wires[wire]
    if @wire_instructions[wire].match(@assign_value)
      # 123 -> x
      @wires[wire] = @wire_instructions[wire].to_i
    elsif @wire_instructions[wire].match(@assign_wire)
      # y -> x
      @wires[wire] = wire_value(@wire_instructions[wire])
    elsif @wire_instructions[wire].match(@unary)
      # NOT a -> b
      match = @wire_instructions[wire].match(@unary)
      @wires[wire] = ~wire_value(match[1])
    else
      # x AND y -> z
      match = @wire_instructions[wire].match(@binary)
      case match[2]
      when 'AND'
        if match[1] == '1'
          @wires[wire] = wire_value(match[3]) & 1
        else
          @wires[wire] = wire_value(match[1]) & wire_value(match[3])
        end
      when 'OR'
        @wires[wire] = wire_value(match[1]) | wire_value(match[3])
      when 'LSHIFT'
        @wires[wire] = wire_value(match[1]) << match[3].to_i
      when 'RSHIFT'
        @wires[wire] = wire_value(match[1]) >> match[3].to_i
      end
    end
  end
end

logic_gate = LogicGate.new(File.read('day7-input.txt').lines)

puts "Wire A: #{logic_gate.wire_value('a')}"

# Part 2: Override Wire B for Wire A

logic_gate = LogicGate.new(File.read('day7-input.txt').lines, true)

puts "Wire A: #{logic_gate.wire_value('a')}"
