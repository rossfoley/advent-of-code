class DecompressorSection
  def initialize input, multiplier
    @input = input
    @multiplier = multiplier
    @unexpanded_count = 0
    @children = []
  end

  # Convert input string into hierarchy of child sections
  def process
    remaining = @input
    while remaining.length > 0
      match = remaining.match /(.*?)\((\d+)x(\d+)\)(.+)/
      if match.nil?
        @unexpanded_count = remaining.length
        remaining = ''
      else
        before, rest = match[1], match[4]
        length, times = match[2].to_i, match[3].to_i
        next_marker = rest.index('(', length) || rest.length

        child_section = DecompressorSection.new(rest[0...length], times)
        child_section.process
        @children << child_section

        @unexpanded_count += next_marker - length + before.length
        remaining = rest[next_marker..-1]
      end
    end
  end

  def decompressed_length
    children_length = @children.map {|c| c.decompressed_length}.reduce(:+) || 0
    (@multiplier * children_length) + @unexpanded_count
  end
end

input = File.read('input.txt').lines[0].strip
decompressor = DecompressorSection.new(input, 1)
decompressor.process

puts "Part 2: #{decompressor.decompressed_length}"
