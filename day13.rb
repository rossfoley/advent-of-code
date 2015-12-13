class Seating
  def initialize input
    @preferences = {}
    @people = []
    input.each do |preference|
      match = preference.match(/(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)\./)
      @preferences[match[1]] ||= {}
      @preferences[match[1]][match[4]] = match[3].to_i
      @preferences[match[1]][match[4]] *= -1 if match[2] == 'lose'
      @people << match[1] unless @people.include? match[1]
    end
  end

  def optimal_happiness
    (1..100000).map do
      total_happiness(@people.shuffle)
    end.max
  end

  def add_myself
    @people << 'Ross'
    @preferences['Ross'] = {}
    @people.each do |person|
      @preferences[person]['Ross'] = 0
      @preferences['Ross'][person] = 0
    end
  end

  def total_happiness seating
    seating.each_with_index.map do |person, i|
      left = seating[(i - 1) % seating.size]
      right = seating[(i + 1) % seating.size]
      @preferences[person][left] + @preferences[person][right]
    end.reduce(:+)
  end
end

# Part 1: Optimal happiness
seating = Seating.new(File.read('day13-input.txt').lines)
puts "Best happiness: #{seating.optimal_happiness}"

# Part 2: Optimal happiness with myself added
seating.add_myself
puts "Best happiness with Ross: #{seating.optimal_happiness}"
