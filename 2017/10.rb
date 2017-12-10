input = File.read("10_input.txt").strip

# Part 1
# vals = input.split(',').map(&:to_i)
# rounds = 1

# Part 2
suffix = [17, 31, 73, 47, 23]
vals = input.chars.map(&:ord) + suffix
rounds = 64

list = (0...256).map(&:to_i)
index = 0
skip = 0

rounds.times do
  vals.each do |val|
    sublist_indices = (index..(index+val-1)).map(&:to_i).map { |i| i % list.length }
    (0..(val-1)/2).each do |i|
      curr_index = sublist_indices[i]
      swap_index = sublist_indices[sublist_indices.length-1-i]
      swap = list[swap_index]
      list[swap_index] = list[curr_index]
      list[curr_index] = swap
    end
    index = (index + val + skip) % list.length
    skip += 1
  end
end

# Part 1
# puts list[0] * list[1]

# Part 2
dense = []
16.times do |i|
  index = i * 16
  dense << list[index...index+16].inject(:^)
end
puts dense.map { |c| c.to_s(16).rjust(2, '0') }.join
