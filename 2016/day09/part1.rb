class Decompressor
  attr_reader :output

  def initialize input
    @input = input
    @remaining = input
    @output = ''
  end

  def expand_input
    expanding = true
    while expanding
      expanding = expand_marker
    end
  end

  def expand_marker
    return false unless @remaining.length > 0

    match = @remaining.match /\((\d+)x(\d+)\)(.+)/
    return false unless match

    length, times, rest = match[1].to_i, match[2].to_i, match[3]
    expanded = rest[0...length] * times
    next_marker = rest.index('(', length) || rest.length
    before_next_marker = rest[length...next_marker]
    @output << "#{expanded}#{before_next_marker}"
    @remaining = rest[next_marker..-1]
    true
  end
end

input = File.read('input.txt').lines[0].strip
decompressor = Decompressor.new input
decompressor.expand_input

puts "Part 1: #{decompressor.output.length}"
