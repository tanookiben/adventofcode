grid = []

file = File.open('22_input.txt', 'r')
file.each_line do |l|
  grid << l.strip.split('')
end

x, y = [grid[0].length / 2, grid.length/2]

pad_x = (10000 - grid[0].length) / 2
pad_y = (10000 - grid.length) / 2

grid = grid.map do |row|
  padding = ['.'] * pad_x
  padding + row + padding
end

padding = ['.'] * grid[0].length
pad_y.times do
  grid.unshift(padding.clone)
  grid.push(padding.clone)
end

x += pad_x
y += pad_y
dir = :up

def turn(direction, state)
  case direction
  when :up
    case state
    when '#'
      :right
    when '.'
      :left
    when 'W' # Part 2
      :up
    when 'F' # Part 2
      :down
    else
      raise 'Invalid state'
    end
  when :right
    case state
    when '#'
      :down
    when '.'
      :up
    when 'W'
      :right
    when 'F'
      :left
    else
      raise 'Invalid state'
    end
  when :down
    case state
    when '#'
      :left
    when '.'
      :right
    when 'W'
      :down
    when 'F'
      :up
    else
      raise 'Invalid state'
    end
  when :left
    case state
    when '#'
      :up
    when '.'
      :down
    when 'W'
      :left
    when 'F'
      :right
    else
      raise 'Invalid state'
    end
  else
    raise 'Invalid direction'
  end
end

def process(grid, x, y, dir)
  case grid[y][x]
  when '#'
    state = '#'
    result = 'F'
  when '.'
    state = '.'
    result = 'W'
  when 'W' # Part 2
    state = 'W'
    result = '#'
  when 'F' # Part 2
    state = 'F'
    result = '.'
  else
    raise 'Invalid state'
  end

  grid[y][x] = result
  turned = turn(dir, state)

  case turned
  when :up
    return result, x, y-1, turned
  when :right
    return result, x+1, y, turned
  when :down
    return result, x, y+1, turned
  when :left
    return result, x-1, y, turned
  else
    raise 'Invalid direction'
  end
end

# Part 1
# n = 10000

# Part 2
n = 10000000

infect_count = 0
n.times do
  infect, x, y, dir = process(grid, x, y, dir)
  infect_count += 1 if infect == '#'
end
puts infect_count
