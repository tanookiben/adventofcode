digits = File.read("01_input.txt").strip
sum = 0

# Part 1
# incr = 1

# Part 2
incr = digits.length / 2

for i in 0...digits.length
  cur = digits[i%digits.length]
  nex = digits[(i+incr)%digits.length]
  if cur == nex
    sum += cur.to_i
  end
end
puts sum
