class Duet
  attr_reader :registers, :instructions, :pc, :receiving, :sending, :sent, :waiting

  def initialize instructions, p
    @registers = {'p' => p}
    @instructions = parse_instructions instructions
    @pc = 0
    @receiving = []
    @sending = []
    @sent = 0
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
      @sending.unshift(parse_value cmd[:args][0])
      @sent += 1
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
      return if @receiving.empty?
      @registers[cmd[:args][0]] = @receiving.pop
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

  def receive value
    @receiving.unshift value
  end

  def finished?
    @pc < 0 || @pc >= @instructions.size || deadlock?
  end

  def deadlock?
    cmd = @instructions[@pc]
    cmd[:instruction] == 'rcv' && @receiving.empty? && @sending.empty?
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
  def part2 input
    duet0 = Duet.new input, 0
    duet1 = Duet.new input, 1

    while true
      break if duet0.finished? && duet1.finished?

      # Run the next instruction for each program
      duet0.tick
      duet1.tick

      # Send program 0 values to program 1
      unless duet0.sending.empty?
        duet1.receive duet0.sending.pop
      end

      # Send program 1 values to program 0
      unless duet1.sending.empty?
        duet0.receive duet1.sending.pop
      end
    end

    duet1.sent
  end
end

day18 = Day18.new
input = File.read('input.txt').lines.map(&:strip)

part2 = day18.part2(input)
puts "Part 2: #{part2}"
