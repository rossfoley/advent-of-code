class Assembunny
  attr_accessor :registers

  ONE_ARG = /(inc|dec|tgl|out) (-?\d+|a|b|c|d)/
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
        {instruction: match[1], args: convert_args([match[2]]).first}
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

  def lowest_a
    a = -1
    output = [0,0,0,0,0,0,0,0,0,0]
    while output != [0,1,0,1,0,1,0,1,0,1]
      a += 1
      @registers = {a: a, b: 0, c: 0, d: 0}
      output = run_program
    end
    a
  end

  def run_program
    @pc = 0
    @output = []

    while @output.length < 10
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

        when 'out'
          @output << read_value(cmd[:args])
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
    @output
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
lowest_a = machine.lowest_a
puts "[Part 1] Register a: #{lowest_a}"
