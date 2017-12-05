file = File.open("04_input.txt", "r")
count = 0

def parse(phrase)
  # Part 2
  phrase.split('').sort
end

file.each_line do |l|
  phrases = Hash.new(false)
  dupe = false
  l.strip.split(/\s/).each do |phrase|
    # Part 2
    phrase = parse(phrase)
    # Part 1
    if phrases[phrase]
      dupe = true
    end
    phrases[phrase] = phrase
  end
  count += dupe ? 0 : 1
end
puts count
