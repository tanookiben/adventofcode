# Day 10
def knot_hash(input)
  bytes = input.chars.map(&:ord) + [17, 31, 73, 47, 23]

  list = (0...256).map(&:to_i)
  index = 0
  skip = 0
  rounds = 64

  rounds.times do
    bytes.each do |byte|
      sublist_indices = (index..(index + byte - 1)).map(&:to_i).map { |i| i % list.length }
      (0..(byte - 1)/2).each do |i|
        curr_index = sublist_indices[i]
        swap_index = sublist_indices[sublist_indices.length - 1 - i]
        swap = list[swap_index]
        list[swap_index] = list[curr_index]
        list[curr_index] = swap
      end
      index = (index + byte + skip) % list.length
      skip += 1
    end
  end

  dense = []
  16.times do |i|
    index = i * 16
    dense << list[index...index+16].inject(:^)
  end
  dense.map { |c| c.to_s(16).rjust(2, '0') }.join
end

def knot_bits(hash)
  bits = []
  hash.chars.each do |char|
    bits << char.to_i(16).to_s(2).rjust(4, '0')
  end
  bits.join
end

class Point
  def initialize(y, x)
    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end

  def hash
    "y#{@y}x#{@x}"
  end
end

input = "vbqugkhl"
grid = []
count = 0
dim = 128
dim.times do |i|
  bits = knot_bits(knot_hash("#{input}-#{i}")).chars
  grid << bits
  count += bits.count("1")
end

# Part 1
puts count

visited = {}
regions = 0
grid.length.times do |y|
  grid.length.times do |x|
    point = Point.new(y, x)
    next if visited[point.hash]
    next if grid[y][x] != "1"

    visit = [point]
    regions += 1

    while(visit.length > 0) do
      current = visit.shift
      visited[current.hash] = true

      # down
      if current.y + 1 < grid.length
        if grid[current.y + 1][current.x] == "1"
          next_point = Point.new(current.y + 1, current.x)
          visit << next_point if !visited[next_point.hash]
        end
      end
      # up
      if current.y - 1 >= 0
        if grid[current.y - 1][current.x] == "1"
          next_point = Point.new(current.y - 1, current.x)
          visit << next_point if !visited[next_point.hash]
        end
      end
      # right
      if current.x + 1 < grid.length
        if grid[current.y][current.x + 1] == "1"
          next_point = Point.new(current.y, current.x + 1)
          visit << next_point if !visited[next_point.hash]
        end
      end
      # left
      if current.x - 1 >= 0
        if grid[current.y][current.x - 1] == "1"
          next_point = Point.new(current.y, current.x - 1)
          visit << next_point if !visited[next_point.hash]
        end
      end
    end
  end
end

# Part 2
puts regions
