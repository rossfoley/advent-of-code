class WhiteElephant
  def initialize count
    @count = count
    @elves = (1..count).map {|i| {number: i, presents: 1}}
    @index = 0
    @remaining = count
  end

  def run
    (@count - 1).times do
      tick
    end
    @elves[0][:number]
  end

  def tick
    elf = @elves[@index]
    next_elf = @elves[next_elf_index @index]
    elf[:presents] += next_elf[:presents]
    @elves.delete next_elf
    @remaining -= 1
    @index = next_elf_index @elves.index(elf)
  end

  def next_elf_index index
    half = (@remaining / 2).floor
    (index + half) % @remaining
  end
end

party = WhiteElephant.new 3017957
winner = party.run

puts "[Part 2] #{winner}"
