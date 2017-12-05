def part_one(vals)
  return vals.max.to_i - vals.min.to_i
end

def part_two(vals)
  vals = vals.sort.reverse
  (0...vals.length).each do |j|
    cur = vals[j]
    (j+1...vals.length).each do |k|
      nex = vals[k]
      if cur % nex == 0
        return cur / nex
      end
      if nex % cur == 0 
        return nex / cur
      end
    end
  end
  return 0
end

file = File.open("input_02.txt", "r")
sum = 0
file.each_line do |l|
  vals = l.strip.split(/\s/).map(&:to_i)
  sum += part_two(vals)
end
puts sum
