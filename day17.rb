class EggNogStorage
  def initialize
    @containers = File.read('day17-input.txt').lines.map(&:to_i)
    @total_eggnog = 150
  end

  def container_combinations
    total = 0
    (3..@containers.size).each do |size|
      combinations = @containers.combination(size).to_a
      combinations.each do |combination|
        total += 1 if combination.reduce(:+) == @total_eggnog
      end
    end
    total
  end

  def minimum_combinations
    total = 0
    combinations = @containers.combination(4).to_a
    combinations.each do |combination|
      total += 1 if combination.reduce(:+) == @total_eggnog
    end
    total
  end
end

storage = EggNogStorage.new
puts "Combinations for Part 1: #{storage.container_combinations}"
puts "Combinations for Part 2: #{storage.minimum_combinations}"
