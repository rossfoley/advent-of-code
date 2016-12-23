class Assembunny
  attr_accessor :registers

  ONE_ARG = /(inc|dec|tgl) (a|b|c|d)/
  JNZ = /jnz (-?\d+|a|b|c|d) (-?\d+|a|b|c|d)/
  CPY = /cpy (-?\d+|a|b|c|d) (a|b|c|d)/

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
        {instruction: 'jnz', args: convert_args([match[1], match[2]])}
      elsif instruction.match(CPY)
        match = instruction.match(CPY)
        {instruction: 'cpy', args: convert_args([match[1], match[2]])}
      else
        puts "Error parsing instruction: #{instruction}"
      end
    end
  end

  def convert_args args
    args.map do |arg|
      if ['a', 'b', 'c', 'd'].include? arg
        arg.to_sym
      else
        arg.to_i
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

        when 'tgl'
          toggle_instruction @pc + @registers[cmd[:args]]
          @pc += 1

        when 'jnz'
          check, offset = cmd[:args]
          if read_value(check) != 0
            @pc += read_value(offset)
          else
            @pc += 1
          end

        when 'cpy'
          from, to = cmd[:args]
          if to.is_a? Fixnum
            # Skip invalid instructions like cpy 1 2
            @pc += 1
          else
            @registers[to] = read_value(from)
            @pc += 1
          end

        else break
      end
    end
  end

  def read_value val
    if val.is_a? Symbol
      @registers[val]
    else
      val
    end
  end

  def toggle_instruction i
    return if i >= @instructions.length || i < 0
    new_cmd =
      case @instructions[i][:instruction]
      when 'inc' then 'dec'
      when 'dec' then 'inc'
      when 'tgl' then 'inc'
      when 'jnz' then 'cpy'
      when 'cpy' then 'jnz'
      end
    @instructions[i][:instruction] = new_cmd
  end
end

machine = Assembunny.new(File.read('input.txt').lines)
machine.registers = {a: 7, b: 0, c: 0, d: 0}
machine.run_program
puts "[Part 1] Register a: #{machine.registers[:a]}"

machine = Assembunny.new(File.read('input.txt').lines)
machine.registers = {a: 12, b: 0, c: 0, d: 0}
machine.run_program
puts "[Part 2] Register a: #{machine.registers[:a]}"
