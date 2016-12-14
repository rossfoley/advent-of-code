require 'digest'

class OneTimePad
  attr_reader :key_indices

  HEX_CHARS = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

  def initialize input
    @input = input
    @index = -1
    @key_indices = []
    @hashes = []
  end

  def find_64th_key
    65.times { find_next_key }
    @index
  end

  def find_next_key
    while true
      @index += 1

      hash = md5 @index
      repeat = HEX_CHARS.select {|c| hash.include?(c * 3)}
      next if repeat.empty?

      char = repeat[0]
      match = matches_five_index char
      if match >= 0
        @key_indices << {index: @index, five: match, char: char}
        return true
      end
    end
  end

  def matches_five_index char
    first, last = @index + 1, @index + 1000
    (first..last).each do |i|
      hash = md5 i
      return i if hash.include?(char * 5)
    end
    -1
  end

  def md5 index
    if @hashes[index]
      @hashes[index]
    else
      hash = Digest::MD5.hexdigest "#{@input}#{index}"
      2016.times { hash = Digest::MD5.hexdigest hash }
      @hashes[index] = hash
    end
  end
end

pad = OneTimePad.new 'ngcjuoqr'
key_index_64 = pad.find_64th_key

puts "[Part 2] #{key_index_64} produces the 64th key"
