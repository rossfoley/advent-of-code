class Room
  attr_reader :name, :sector_id, :checksum

  def initialize name, sector_id, checksum
    @name = name
    @sector_id = sector_id
    @checksum = checksum
  end

  def real?
    name_checksum == @checksum
  end

  def name_checksum
    groups = @name.tr('-', '').chars.group_by {|a| a}
    groups = groups.values.map do |group|
      { char: group[0], length: group.length }
    end
    sorted_groups = groups.sort {|a, b| [b[:length], a[:char]] <=> [a[:length], b[:char]]}
    sorted_groups.take(5).map {|a| a[:char]}.join('')
  end

  def decoded_name
    shift = @sector_id % 26
    shifted_name = @name.chars.map {|char| shift_char char, shift}
    shifted_name.join ''
  end

  def shift_char char, shift
    return ' ' if char == '-'
    result = (char.ord - 'a'.ord + shift) % 26 + 'a'.ord
    result.chr
  end
end

test_input = [
  'aaaaa-bbb-z-y-x-123[abxyz]',
  'a-b-c-d-e-f-g-h-987[abcde]',
  'not-a-real-room-404[oarel]',
  'totally-real-room-200[decoy]'
]

input = File.read('input.txt').lines

rooms = input.map do |line|
  match = line.match /([a-z-]+)-(\d+)\[(\w+)\]/
  Room.new match[1], match[2].to_i, match[3]
end

real_rooms = rooms.select(&:real?)

real_sum = real_rooms.map(&:sector_id).reduce(:+)
puts "Part 1: Sector ID Sum #{real_sum}"

part2_room = real_rooms.select {|room| room.decoded_name == 'northpole object storage'}.first
puts "Part 2: Sector ID #{part2_room.sector_id}"
