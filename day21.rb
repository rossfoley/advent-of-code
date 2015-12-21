class SantaRPG
  ENEMY = {
      hp: 103,
      damage: 9,
      armor: 2
  }
  def initialize
    item_regex = /.+? (\d+).+?(\d+).+?(\d+)/
    @weapons, @armor, @rings = %w(weapons armor rings).map do |type|
      File.read("day21-#{type}.txt").lines.map do |line|
        match = line.match item_regex
        {
            cost: match[1].to_i,
            damage: match[2].to_i,
            armor: match[3].to_i
        }
      end
    end
    @weapon_options = (0...@weapons.size).to_a.combination(1).to_a
    @armor_options = [[]] + (0...@armor.size).to_a.combination(1).to_a
    @ring_options = [[]] + (0...@rings.size).to_a.combination(1).to_a + (0...@rings.size).to_a.combination(2).to_a
  end

  def combinations
    equipment_options = []
    @weapon_options.each do |weapon_option|
      @armor_options.each do |armor_option|
        @ring_options.each do |ring_option|
          equipment_options << [weapon_option, armor_option, ring_option]
        end
      end
    end
    equipment_options
  end

  def cheapest_option
    combos = combinations
    combos.sort! do |a, b|
      total_cost(a) <=> total_cost(b)
    end
    combos.each do |combo|
      if can_win?(combo)
        puts "Part 1: #{total_cost(combo)}"
        break
      end
    end
  end

  def expensive_option
    combos = combinations
    combos.sort! do |a, b|
      total_cost(b) <=> total_cost(a)
    end
    most_expensive = combos.reject do |combo|
      can_win?(combo)
    end.first
    puts "Part 2: #{total_cost(most_expensive)}"
  end

  def can_win?(combo)
    my_damage = total_damage(combo) - ENEMY[:armor]
    enemy_damage = [ENEMY[:damage] - total_armor(combo), 1].max
    my_turns = (ENEMY[:hp].to_f / my_damage).ceil
    enemy_turns = (100.0 / enemy_damage).ceil
    (my_turns - 1) < enemy_turns
  end

  def total_cost combo
    total(combo, :cost)
  end

  def total combo, field
    attr(combo[0], @weapons, field) + attr(combo[1], @armor, field) + attr(combo[2], @rings, field)
  end

  def total_damage combo
    total(combo, :damage)
  end

  def total_armor combo
    total(combo, :armor)
  end

  def attr item, type, field
    item.inject(0) do |sum, a|
      sum + type[a][field]
    end
  end
end

santa = SantaRPG.new()
santa.cheapest_option
santa.expensive_option
