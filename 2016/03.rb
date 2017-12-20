triangles = []
valid = 0

file = File.open('03_input.txt', 'r')

# Part 1
# file.each_line do |l|
#   triangles << l.strip.split(' ').map(&:to_i).sort
# end
# triangles.each do |t|
#   valid += 1 if t[0] + t[1] > t[2] 
# end

# Part 2
cols = [
  [],
  [],
  [],
]
file.each_line do |l|
  raw = l.strip.split(' ').map(&:to_i)
  cols[0] << raw[0]
  cols[1] << raw[1]
  cols[2] << raw[2]
end
cols.each do |col|
  n = col.length / 3
  n.times do |i|
    t = col[i*3..i*3+2].sort
    valid += 1 if t[0] + t[1] > t[2]
  end
end

puts valid
