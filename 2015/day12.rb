require 'json'

# Part 1: Sum of Numbers
input = File.read('day12-input.txt').lines.first
sum = input.scan(/-?\d+/).map(&:to_i).reduce(:+)
puts "Sum of all numbers: #{sum}"

# Part 2: Ignore red
class JSONSummer
  def initialize json
    @json = json
  end

  def call
    json_sum(@json)
  end

  def json_sum json
    if json.is_a? Array
      json.map{|j| json_sum(j)}.reduce(:+)
    elsif json.is_a? Hash
      return 0 if json.values.include? 'red'
      json.values.map{|v| json_sum(v)}.reduce(:+)
    elsif json.is_a? Integer
      json
    else
      0
    end
  end
end

summer = JSONSummer.new(JSON.parse(input))
sum = summer.call
puts "Sum without red: #{sum}"
