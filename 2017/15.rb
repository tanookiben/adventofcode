a_start = 679
b_start = 771
# a_start = 65
# b_start = 8921

a_factor = 16807
b_factor = 48271

div = 2147483647

# Part 1
# n = 40000000

# Part 2
n = 5000000

def generate(input, factor, div)
  (input * factor) % div
end

def match?(a, b)
  a_binary = a.to_s(2).rjust(32, "0")
  b_binary = b.to_s(2).rjust(32, "0")
  a_binary[16..-1] == b_binary[16..-1]
end

a_val = a_start
b_val = b_start
match_count = 0
n.times do |i|
  a_val = generate(a_val, a_factor, div)
  while(a_val % 4 != 0) do
    # Part 2
    a_val = generate(a_val, a_factor, div)
  end
  b_val = generate(b_val, b_factor, div)
  while(b_val % 8 != 0) do
    # Part 2
    b_val = generate(b_val, b_factor, div)
  end
  match_count += 1 if match?(a_val, b_val)
end
puts match_count
