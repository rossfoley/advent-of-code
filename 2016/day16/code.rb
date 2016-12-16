class DragonCurve
  attr_reader :current

  def initialize start, length
    @start = start
    @current = start.dup
    @final_length = length
  end

  def final_checksum
    str = generate
    check = checksum(str)
    while check.length % 2 == 0
      check = checksum(check)
    end
    check
  end

  def checksum str
    str.chars.each_slice(2).map do |p|
      p[0] == p[1] ? '1' : '0'
    end.join ''
  end

  def generate
    while @current.length < @final_length
      tick
    end
    @current[0...@final_length]
  end

  def tick
    @current = "#{@current}0#{invert(@current)}"
  end

  def invert str
    str.reverse.gsub('0', 'a').gsub('1', '0').gsub('a', '1')
  end
end

curve = DragonCurve.new '00111101111101000', 272
checksum = curve.final_checksum

puts "[Part 1] #{checksum}"

curve = DragonCurve.new '00111101111101000', 35651584
checksum = curve.final_checksum

puts "[Part 2] #{checksum}"
