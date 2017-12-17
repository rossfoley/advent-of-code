class Dance
  attr_accessor :programs

  SPIN = /s(\d+)/
  EXCHANGE = /x(\d+)\/(\d+)/
  PARTNER = /p(\w)\/(\w)/

  def initialize
    @programs = ('a'..'p').to_a
  end

  def spin num
    @programs.rotate! -num
  end

  def exchange i, j
    @programs[i], @programs[j] = @programs[j], @programs[i]
  end

  def partner pa, pb
    i = @programs.index pa
    j = @programs.index pb
    exchange i, j
  end

  def apply_moves moves
    moves.each do |move|
      if move.match SPIN
        match = move.match SPIN
        spin match[1].to_i
      elsif move.match EXCHANGE
        match = move.match EXCHANGE
        exchange match[1].to_i, match[2].to_i
      elsif move.match PARTNER
        match = move.match PARTNER
        partner match[1], match[2]
      else
        puts "Unknown move: #{move}"
        return
      end
    end
  end
end

class Day16
  def part1 input
    moves = input.split ','
    dance = Dance.new
    dance.apply_moves moves

    dance.programs.join
  end

  def part2 input
    moves = input.split ','
    dance = Dance.new

    latest = nil
    history = []
    
    # Find the cycle length of this set of moves
    while !history.include? latest
      history << latest
      dance.apply_moves moves
      latest = dance.programs.dup
    end

    history.compact!

    # Convert 1 billion into the cycle index
    i = (1e9.to_i % history.size) - 1

    history[i].join
  end
end

day16 = Day16.new
input = File.read('input.txt').lines.first.strip

part1 = day16.part1(input)
puts "Part 1: #{part1}"

part2 = day16.part2(input)
puts "Part 2: #{part2}"
