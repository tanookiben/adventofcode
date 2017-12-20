def process(pad, x, y, moves)
  moves.each do |m|
    case m
    when 'U'
      if y-1 < 0 || pad[y-1][x] == ' '
        next
      end
      y -= 1
    when 'D'
      if y+1 >= pad.length || pad[y+1][x] == ' '
        next
      end
      y += 1
    when 'R'
      if x+1 >= pad.length || pad[y][x+1] == ' '
        next
      end
      x += 1
    when 'L'
      if x-1 < 00 || pad[y][x-1] == ' '
        next
      end
      x -= 1
    else
      raise 'Unknown direction'
    end
  end
  return pad[y][x], x, y
end

# Part 1
# pad = [
#   [1, 2, 3],
#   [4, 5, 6],
#   [7, 8, 9]
# ]
# x, y = 1, 1

# Part 2
pad = [
  [' ', ' ', '1', ' ', ' '],
  [' ', '2', '3', '4', ' '],
  ['5', '6', '7', '8', '9'],
  [' ', 'A', 'B', 'C', ' '],
  [' ', ' ', 'D', ' ', ' '],
]
x, y = 0, 2

code = []

file = File.open('02_input.txt', 'r')
file.each_line do |l|
  moves = l.strip.split('')
  n, x, y = process(pad, x, y, moves)
  code << n
end

puts code.join('')
