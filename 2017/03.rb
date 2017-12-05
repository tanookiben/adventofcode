# S^2 - 2(S-1)  . . . . . S^2 - 3(S-1)
#               .       .
#               .       .
#               .       . 
# S^2 - 1(S-1)  . . . . . S^2

val = 312051

dim = 1
while dim**2 < val
  dim += 2
end

def part_one(val, dim)
  travel = dim / 2

  case val
  when dim**2-1*(dim-1)..dim**2-0*(dim) # bottom
    min = dim**2-1*(dim-1)
    mid = min + dim/2
    travel += (mid - val).abs
  when dim**2-2*(dim-1)..dim**2-1*(dim-1) # left
    min = dim**2-2*(dim-1)
    mid = min + dim/2
    travel += (mid - val).abs
  when dim**2-3*(dim-1)..dim**2-2*(dim-1) # top
    min = dim**2-3*(dim-1)
    mid = min + dim/2
    travel += (mid - val).abs
  when dim**2-4*(dim)..dim**2-3*(dim-1) # right
    min = dim**2-4*(dim)
    mid = min + dim/2
    travel += (mid - val).abs
  end

  puts travel
end

def sum(x, y)
  sum = 0
  sum += @vals[y][x]
  sum += @vals[y+1][x]
  sum += @vals[y-1][x]
  sum += @vals[y][x+1]
  sum += @vals[y+1][x+1]
  sum += @vals[y-1][x+1]
  sum += @vals[y][x-1]
  sum += @vals[y+1][x-1]
  sum += @vals[y-1][x-1]
  return sum
end

def up_val(x, y)
  @vals[y+1][x]
end

def left_val(x, y)
  @vals[y][x-1]
end

def down_val(x, y)
  @vals[y-1][x]
end

def right_val(x, y)
  @vals[y][x+1]
end

def up(x, y)
  return x, y+1
end

def left(x, y)
  return x-1, y
end

def down(x, y)
  return x, y-1
end

def right(x, y)
  return x+1, y
end

def direction(x, y)
  if right_val(x, y) == 0 && up_val(x, y) == 0 && left_val(x, y) == 0 && down_val(x, y) == 0
    # Start
    return right(x, y)
  end

  if right_val(x, y) == 0
    if left_val(x, y) != 0
      if up_val(x, y) == 0
        return up(x, y)
      end
      # up_val(x, y) != 0
      return right(x, y)
    end
    # left_val(x, y) == 0
    if up_val(x, y) != 0
      return right(x, y)
    end
    # up_val(x, y) == 0
    return left(x, y)
  end

  if left_val(x, y) == 0
    if right_val(x, y) != 0
      if down_val(x, y) == 0
        return down(x, y)
      end
      # down_val(x, y) != 0
      return left(x, y)
    end
    # right_val(x, y) == 0
    if down_val(x, y) != 0
      return left(x, y)
    end
    # down_val(x, y) == 0
    return right(x, y)
  end
end

def part_two(val, dim)
  x = dim / 2
  y = dim / 2
  z = 1

  @vals = []
  dim.times do
    row = []
    dim.times do
      row << 0
    end
    @vals << row
  end

  while(z < val) do
    z = sum(x, y)
    if z == 0
      @vals[y][x] = 1
    else
      @vals[y][x] = z
    end
    x, y = direction(x, y)
  end
  puts z
end

part_one(val, dim)
part_two(val, dim)
