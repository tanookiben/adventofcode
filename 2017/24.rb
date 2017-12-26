pieces = []
file = File.open('24_input.txt', 'r')
file.each_line do |l|
  pieces << l.strip.split('/').map(&:to_i)
end

starters = pieces.select { |x| x[0] == 0 }

def strongest(curr, remaining, prev)
  if remaining.length == 0
    return curr[0] + curr[1]
  end

  val = curr[0] == prev ? curr[1] : curr[0]

  matching = []
  remaining.each do |p|
    matching << p if p.include?(val)
  end

  strongest = 0
  matching.each do |p|
    piece = p
    subset = remaining.dup
    subset.delete_at(remaining.index(piece))
    str = strongest(piece, subset, val)
    strongest = str if str > strongest
  end
  return curr[0] + curr[1] + strongest
end

# DRY is not my middle name
def longest(curr, remaining, prev, length)
  if remaining.length == 0
    return curr[0] + curr[1], 1
  end

  val = curr[0] == prev ? curr[1] : curr[0]

  matching = []
  remaining.each do |p|
    matching << p if p.include?(val)
  end

  strength = 0
  longest = 0
  matching.each do |p|
    piece = p
    subset = remaining.dup
    subset.delete_at(subset.index(piece))
    str, len = longest(piece, subset, val, length + 1)
    if len >= longest
      if str > strength
        strength = str
      end
      longest = len + 1
    end
  end
  return curr[0] + curr[1] + strength, longest + length
end

max = 0
longest = Hash.new(0)
starters.each do |p|
  piece = p
  remaining = pieces.dup
  remaining.delete_at(remaining.index(piece))

  strength = strongest(piece, remaining, 0)
  max = strength if strength > max

  str, length = longest(piece, remaining, 0, 1)
  longest[length] = str
end

# Part 1
puts max

# Part 2
puts longest[longest.keys.max]
