require 'digest/md5'

# Part 1: 5 Zeroes

input = 'ckczppom'
answer = 1
found_answer = false

while not found_answer
  md5 = Digest::MD5.hexdigest(input + answer.to_s)
  if md5[0..4] == '00000'
    found_answer = true 
  else
    answer += 1
  end
end

puts "5 Zeroes Answer: #{answer}"

# Part 2: 6 Zeroes

input = 'ckczppom'
answer = 1
found_answer = false

while not found_answer
  md5 = Digest::MD5.hexdigest(input + answer.to_s)
  if md5[0..5] == '000000'
    found_answer = true 
  else
    answer += 1
  end
end

puts "6 Zeroes Answer: #{answer}"
