class Decompressor
  def initialize input
    @input = input
  end

  def final_length
    decompressed_length @input
  end

  def decompressed_length input
    match = input.match /(.*?)\((\d+)x(\d+)\)(.+)/
    return input.length if match.nil?

    before, length, times, rest = match[1], match[2].to_i, match[3].to_i, match[4]
    before.length + (times * decompressed_length(rest[0...length])) + decompressed_length(rest[length..-1])
  end
end

input = File.read('input.txt').lines[0].strip
decompressor = Decompressor.new input

puts "Part 2: #{decompressor.final_length}"
