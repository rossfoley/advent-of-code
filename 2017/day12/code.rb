class Program
  attr_accessor :id, :pipes

  def initialize id, pipes = []
    @id = id
    @pipes = pipes
  end
end

class Day12
  def parse_pipes connections
    connections.map do |connection|
      match = connection.match /(\d+) <-> (.+)/
      if match
        id = match[1].to_i
        pipes = match[2].split(', ').map(&:to_i)
        [id, Program.new(id, pipes)]
      else
        puts "Error with line: #{line}"
        return
      end
    end.to_h
  end

  def search_group start_id, programs
    group = [start_id]
    frontier = [start_id]

    # Perform depth first search through programs to create the group
    while !frontier.empty?
      # Check the next program
      current_id = frontier.pop
      program = programs[current_id]

      # Add it to the group if it wasn't already there
      group << current_id
      group = group.uniq

      # Add unchecked programs to the frontier
      program.pipes.each do |pipe|
        unless group.include? pipe
          frontier << pipe
        end
      end
    end

    group
  end

  def part1 input
    programs = parse_pipes input
    group = search_group 0, programs
    group.size
  end

  def part2 input
    programs = parse_pipes input
    program_ids = programs.keys
    groups = []

    # Form all possible groups using program_ids
    while !program_ids.empty?
      group = search_group program_ids.first, programs
      groups << group
      program_ids.delete_if {|id| group.include? id }
    end

    groups.size
  end
end

day12 = Day12.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day12.part1(input)
puts "Part 1: #{part1}"

part2 = day12.part2(input)
puts "Part 2: #{part2}"
