class Day23Machine
  attr_accessor :registers

  ONE_ARG = /(hlf|tpl|inc) (a|b)/
  JMP = /jmp ([+|-]\d+)/
  COND_JMP = /(jio|jie) (a|b), ([+|-]\d+)/

  def initialize instructions
    @registers = {a: 0, b: 0}
    @instructions = parse_instructions instructions
  end

  def parse_instructions instructions
    instructions.map do |instruction|
      if instruction.match(ONE_ARG)
        match = instruction.match(ONE_ARG)
        {instruction: match[1], args: match[2].to_sym}
      elsif instruction.match(JMP)
        match = instruction.match(JMP)
        {instruction: 'jmp', args: match[1].to_i}
      elsif instruction.match(COND_JMP)
        match = instruction.match(COND_JMP)
        {instruction: match[1], args: [match[2].to_sym, match[3].to_i]}
      else
        puts "Error parsing instruction: #{instruction}"
      end
    end
  end

  def run_program
    @pc = 0
    while true
      break if @pc >= @instructions.size
      cmd = @instructions[@pc]

      case cmd[:instruction]
        when 'hlf'
          @registers[cmd[:args]] /= 2
          @pc += 1

        when 'tpl'
          @registers[cmd[:args]] *= 3
          @pc += 1

        when 'inc'
          @registers[cmd[:args]] += 1
          @pc += 1

        when 'jmp'
          @pc += cmd[:args]

        when 'jie'
          if @registers[cmd[:args][0]].even?
            @pc += cmd[:args][1]
          else
            @pc += 1
          end

        when 'jio'
          if @registers[cmd[:args][0]] == 1
            @pc += cmd[:args][1]
          else
            @pc += 1
          end

        else break
      end
    end
  end
end

machine = Day23Machine.new(File.read('day23-input.txt').lines)
machine.run_program
puts "[Part 1] Register b: #{machine.registers[:b]}"

machine.registers = {a: 1, b: 0}
machine.run_program
puts "[Part 2] Register b: #{machine.registers[:b]}"
