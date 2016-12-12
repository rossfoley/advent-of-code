class Assembunny
  attr_accessor :registers

  ONE_ARG = /(inc|dec) (a|b|c|d)/
  JNZ = /jnz (a|b|c|d) (-?\d+)/
  JNZ_NUM = /jnz (\d+) (-?\d+)/
  CPY_NUM = /cpy (\d+) (a|b|c|d)/
  CPY_REG = /cpy (a|b|c|d) (a|b|c|d)/

  def initialize instructions
    @registers = {a: 0, b: 0, c: 0, d: 0}
    @instructions = parse_instructions instructions
  end

  def parse_instructions instructions
    instructions.map do |instruction|
      if instruction.match(ONE_ARG)
        match = instruction.match(ONE_ARG)
        {instruction: match[1], args: match[2].to_sym}
      elsif instruction.match(JNZ)
        match = instruction.match(JNZ)
        {instruction: 'jnz', args: [match[1].to_sym, match[2].to_i]}
      elsif instruction.match(JNZ_NUM)
        match = instruction.match(JNZ_NUM)
        {instruction: 'jnz-num', args: [match[1].to_i, match[2].to_i]}
      elsif instruction.match(CPY_NUM)
        match = instruction.match(CPY_NUM)
        {instruction: 'cpy-num', args: [match[1].to_i, match[2].to_sym]}
      elsif instruction.match(CPY_REG)
        match = instruction.match(CPY_REG)
        {instruction: 'cpy-reg', args: [match[1].to_sym, match[2].to_sym]}
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
        when 'inc'
          @registers[cmd[:args]] += 1
          @pc += 1

        when 'dec'
          @registers[cmd[:args]] -= 1
          @pc += 1

        when 'jnz'
          reg, offset = cmd[:args]
          if @registers[reg] != 0
            @pc += offset
          else
            @pc += 1
          end

        when 'jnz-num'
          num, offset = cmd[:args]
          if num != 0
            @pc += offset
          else
            @pc += 1
          end

        when 'cpy-num'
          num, reg = cmd[:args]
          @registers[reg] = num
          @pc += 1

        when 'cpy-reg'
          from, to = cmd[:args]
          @registers[to] = @registers[from]
          @pc += 1

        else break
      end
    end
  end
end

machine = Assembunny.new(File.read('input.txt').lines)
machine.run_program
puts "[Part 1] Register a: #{machine.registers[:a]}"

machine.registers = {a: 0, b: 0, c: 1, d: 0}
machine.run_program
puts "[Part 2] Register a: #{machine.registers[:a]}"
