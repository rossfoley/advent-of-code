class WhiteElephant
  def initialize count
    @count = count
    @elves = (1..count).map {|i| {number: i, presents: 1}}
    @index = 0
  end

  def run
    (@count - 1).times do
      tick
    end
    remaining_elves[0][:number]
  end

  def tick
    elf = @elves[@index]
    next_elf = @elves[next_elf_index]
    elf[:presents] += next_elf[:presents]
    next_elf[:presents] = 0
    @index = next_elf_index
  end

  def next_elf_index
    elf = next_index @index
    while @elves[elf][:presents] == 0
      elf = next_index elf
    end
    elf
  end

  def next_index i
    (i + 1) % @count
  end

  def remaining_elves
    @elves.select {|e| e[:presents] > 0}
  end
end

party = WhiteElephant.new 3017957
winner = party.run

puts "[Part 1] #{winner}"
