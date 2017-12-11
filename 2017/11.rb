paths = File.read('11_input.txt').split(',')

def get_dist(location)
  dist = 0
  target = {x: location[:x].abs, y: location[:y].abs}
  while(target[:x] > 0 && target[:y] > 0) do
    target[:x] -= 1
    target[:y] -= 1
    dist += 1
  end
  return dist + target[:x] + target[:y]/2
end

location = {x: 0, y: 0}
max_dist = 0
paths.each do |path|
  case path
  when 'n'
    location[:y] += 2
  when 'ne'
    location[:x] += 1
    location[:y] += 1
  when 'se'
    location[:x] += 1
    location[:y] -= 1
  when 's'
    location[:y] -= 2
  when 'sw'
    location[:x] -= 1
    location[:y] -= 1
  when 'nw'
    location[:x] -= 1
    location[:y] += 1
  end
  dist = get_dist(location)
  max_dist = dist.abs if dist.abs > max_dist
end

# Part 1
puts get_dist(location)

# Part 2
puts max_dist
