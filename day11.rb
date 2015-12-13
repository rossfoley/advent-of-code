# Part 1: Next password
class PasswordGenerator
  def initialize password
    @password = password
  end

  def next_password
    invalid = true
    while invalid
      @password.next!
      invalid = false if valid? @password
    end
    @password
  end

  def valid? password
    rule1 = false
    password.chars.to_a[0..-3].each_with_index do |char, i|
      first = char.ord
      second = password.chars.to_a[i + 1].ord
      third = password.chars.to_a[i + 2].ord
      rule1 = true if second - first == 1 and third - second == 1
    end

    rule2 = %w(i o l).map{|a| password.index(a)}.reduce{|a, b| a && b}
    rule3 = password.scan(/([a-z])\1/).uniq.size >= 2

    rule1 && rule2 && rule3
  end
end

part1 = PasswordGenerator.new('hxbxwxba')
puts "Next password: #{part1.next_password}"

# Part 2: Yet another password
part2 = PasswordGenerator.new('hxbxxyzz')
puts "Next password: #{part2.next_password}"
