class Particle
  attr_accessor :id, :p, :v, :a, :positions

  def initialize id, p, v, a
    @id = id
    @p = p
    @v = v
    @a = a
    @positions = [@p.dup]
  end

  def tick
    @v[0] += @a[0]
    @v[1] += @a[1]
    @v[2] += @a[2]

    @p[0] += @v[0]
    @p[1] += @v[1]
    @p[2] += @v[2]

    @positions << @p.dup
  end

  def average_distance
    @positions.map {|np| np.map(&:abs).reduce(:+)}.reduce(:+) / @positions.size
  end
end

class Day20
  def generate_particles input
    input.each_with_index.map do |line, index|
      match = line.match /p=<(.+?)>, v=<(.+?)>, a=<(.+?)>/
      unless match
        puts "Can't match line: #{line}"
        return
      end

      p = match[1].split(',').map(&:to_i)
      v = match[2].split(',').map(&:to_i)
      a = match[3].split(',').map(&:to_i)

      Particle.new index, p, v, a
    end
  end

  def part1 input
    particles = generate_particles input

    # 10,000 ticks should be enough to reach a fixed state
    10000.times { particles.each {|p| p.tick}}

    # Find the particles that remained closest to <0,0,0> for the longest
    average = particles.min_by {|p| p.average_distance}
    average.id
  end

  def part2 input
    particles = generate_particles input

    # 10,000 ticks should be enough to reach a fixed state
    10000.times do
      # Remove collided particles
      collision_p = []
      particles.group_by(&:p).each do |p, arr|
        collision_p << p if arr.size > 1
      end
      particles.reject! {|p| collision_p.include? p.p}

      # Move the remaining particles
      particles.each {|p| p.tick}
    end

    particles.size
  end
end

day20 = Day20.new
input = File.read('input.txt').lines.map(&:strip)

part1 = day20.part1(input)
puts "Part 1: #{part1}"

part2 = day20.part2(input)
puts "Part 2: #{part2}"
