def split(pattern)
  size = pattern.length
  case
  when size % 2 == 0
    num = size / 2
    squares = []
    num.times do |y|
      y_val = y * 2
      num.times do |x|
        x_val = x * 2
        squares << [
          [pattern[y_val][x_val], pattern[y_val][x_val+1]],
          [pattern[y_val+1][x_val], pattern[y_val+1][x_val+1]]
        ]
      end
    end
    return squares
  when size % 3 == 0
    num = size / 3
    squares = []
    num.times do |y|
      y_val = y * 3
      num.times do |x|
        x_val = x * 3
        squares << [
          [pattern[y_val][x_val], pattern[y_val][x_val+1], pattern[y_val][x_val+2]],
          [pattern[y_val+1][x_val], pattern[y_val+1][x_val+1], pattern[y_val+1][x_val+2]],
          [pattern[y_val+2][x_val], pattern[y_val+2][x_val+1], pattern[y_val+2][x_val+2]]
        ]
      end
    end
    return squares
  else
    raise 'Invalid size'
  end
end

def format(pattern)
  pattern.map { |row| row.join('') }.join('/')
end

def flip_horizontal(pattern)
  pattern.map { |row| row.reverse }
end

def flip_vertical(pattern)
  case pattern.length
  when 2
    flipped = [
      [pattern[1][0], pattern[1][1]],
      [pattern[0][0], pattern[0][1]]
    ]
    return flipped
  when 3
    flipped = [
      [pattern[2][0], pattern[2][1], pattern[2][2]],
      [pattern[1][0], pattern[1][1], pattern[1][2]],
      [pattern[0][0], pattern[0][1], pattern[0][2]]
    ]
    return flipped
  else
    raise 'Invalid size'
  end
end

def rotate(pattern)
  case pattern.length
  when 2
    rotated = [
      [pattern[1][0], pattern[0][0]],
      [pattern[1][1], pattern[0][1]]
    ]
    return rotated
  when 3
    rotated = [
      [pattern[2][0], pattern[1][0], pattern[0][0]],
      [pattern[2][1], pattern[1][1], pattern[0][1]],
      [pattern[2][2], pattern[1][2], pattern[0][2]]
    ]
    return rotated
  else
    raise 'Invalid size'
  end
end

def convert(pattern, rules)
  check = [
    format(pattern),
    format(flip_horizontal(pattern)),
    format(flip_vertical(pattern)),
    format(rotate(pattern)),
    format(flip_horizontal(rotate(pattern))),
    format(flip_vertical(rotate(pattern))),
    format(rotate(rotate(pattern))),
    format(rotate(rotate(rotate(pattern)))),
  ]
  check.each do |p|
    res = rules[p]
    if !res.nil?
      return res
    end
  end
  raise 'Missing rule'
end

def build(squares)
  dim = Math.sqrt(squares.length).to_i
  size = squares.first.length
  result = []
  dim.times do |d|
    size.times do |i|
      result << squares[dim * d...dim * (d+1)].map { |x| x[i] }.flatten
    end
  end
  return result
end

pattern = [
  ['.', '#', '.'],
  ['.', '.', '#'],
  ['#', '#', '#']
]

rules = {}

file = File.open('21_input.txt', 'r')
file.each_line do |l|
  l.match(/([\.\#\/]+) \=\> ([\.\#\/]+)/)
  pat = $1
  result = $2
  square = []
  result.split('/').each do |row|
    square << row.split('')
  end
  rules[pat] = square
end

18.times do |i|
  a = split(pattern)
  b = []
  a.each do |x|
    b << convert(x, rules)
  end
  pattern = build(b)

  # Part 1
  puts format(pattern).count('#') if i == 4
end

# Part 2
puts format(pattern).count('#')
