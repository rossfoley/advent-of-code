class Factory
  attr_reader :bots, :outputs, :history, :rules

  VALUE_RULE = /value (\d+) goes to bot (\d+)/
  GIVES_RULE = /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/

  def initialize rules
    @bots = {}    
    @outputs = {}
    @history = []
    @rules = {}

    rules.each do |rule|
      apply_rule rule
    end
  end

  def apply_rule rule
    if rule.match VALUE_RULE
      match = rule.match VALUE_RULE
      value, bot = match[1].to_i, match[2].to_i
      give_value 'bot', bot, value
    elsif rule.match GIVES_RULE
      match = rule.match GIVES_RULE
      giver = match[1].to_i
      low = {type: match[2], number: match[3].to_i}
      high = {type: match[4], number: match[5].to_i}
      @rules[giver] = {low: low, high: high}
    else
      puts "Error parsing rule: #{rule}"
    end
  end

  def run
    running = true
    while running
      running = tick
    end
  end

  def tick
    filled_bots = @bots.select {|k, v| v.length == 2}
    return false unless filled_bots.length > 0
    bot = filled_bots.keys.first
    rule = @rules[bot]
    low, high = @bots[bot].sort
    give_value rule[:low][:type], rule[:low][:number], low
    give_value rule[:high][:type], rule[:high][:number], high
    @bots[bot] = []
    true
  end

  def give_value type, number, value
    if type == 'bot'
      @bots[number] ||= []
      @bots[number] << value
      @history << {bot: number, values: @bots[number].dup}
    elsif type == 'output'
      @outputs[number] = value
    else
      puts "Invalid type: #{type}"
    end
  end
end

rules = File.read('input.txt').lines
factory = Factory.new rules
factory.run

bot = factory.history.select {|bot| bot[:values].sort == [17, 61]}.first
puts "Part 1: #{bot[:bot]}"

part2 = factory.outputs[0] * factory.outputs[1] * factory.outputs[2]
puts "Part 2: #{part2}"
