# Part 1: How Many Nice Strings?
def nice? word
  %w(ab cd pq xy).each { |a| return false unless word.index(a).nil? }
  word.scan(/[aeiou]/).size >= 3 && word.scan(/(\w)\1+/).size > 0
end
words = File.read('day5-input.txt').lines
nice_words = words.map{|word| nice?(word)}.count(true)
puts "Number of Nice Words: #{nice_words}"

# Part 2: Better Nice Rules

naughty_or_nice = words.map do |word|
  cond1 = false
  word.chars.each_with_index do |_, i|
    if i < (word.chars.length - 2)
      letters = word[i] + word[i+1]
      cond1 = true if word.scan(/(#{letters})/).size > 1
    end
  end

  cond2 = false
  word.chars.each_with_index do |char, i|
    unless i >= (word.chars.length - 3)
      cond2 = true if word[i + 2] == char 
    end
  end

  cond1 and cond2
end
puts "Number of Nice Words (Part 2): #{naughty_or_nice.count(true)}"
