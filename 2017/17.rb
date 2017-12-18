cycles = 349
buffer = [0]
pos = 0
val = 0

2017.times do |i|
  pos += cycles
  pos = pos % (i + 1)
  pos += 1
  buffer.insert(pos, (i + 1))
end

# Part 1
puts buffer[buffer.index(2017) + 1]

target = 0
pos = 0
50000000.times do |i|
  pos += cycles
  pos = pos % (i + 1)
  pos += 1
  target = i + 1 if pos == 1
end

# Part 2
puts target

