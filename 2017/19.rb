def move(map, x, y, dir)
  curr = map[y][x]

  # Please don't judge me

  case curr
  when '|'
    case dir
    when :down
      case map[y-1][x]
      when '|', '+'
        return map[y-1][x], x, y-1, dir
      when '-'
        return map[y-2][x], x, y-2, dir
      when /[A-Z]/
        return map[y-1][x], x, y-1, dir
      else
        return '', x, y, :done
      end
    when :up
      case map[y+1][x]
      when '|', '+'
        return map[y+1][x], x, y+1, dir
      when '-'
        return map[y+2][x], x, y+2, dir
      when /[A-Z]/
        return map[y+1][x], x, y+1, dir
      else
        return '', x, y, :done
      end
    else
      raise 'Unknown direction'
    end
  when '+'
    case dir
    when :down, :up
      try_right = map[y][x+1]
      try_left = map[y][x-1]
      case
      when try_right == '-' || try_right == '+' || try_right =~ /[A-Z]/
        return try_right, x+1, y, :right
      when try_left == '-' || try_left == '+' || try_left =~ /[A-Z]/
        return try_left, x-1, y, :left
      when try_right == '|'
        return map[y][x+2], x+2, y, :right
      when try_left == '|'
        return map[y][x-2], x-2, y, :left
      else
        return '', x, y, :done
      end
    when :right, :left
      try_down = map[y-1][x]
      try_up = map[y+1][x]
      case
      when try_down == '|' || try_down == '+' || try_down =~ /[A-Z]/
        return try_down, x, y-1, :down
      when try_up == '|' || try_up == '+' || try_up =~ /[A-Z]/
        return try_up, x, y+1, :up
      when try_down == '-'
        return map[y-2][x], x, y-2, :down
      when try_up == '-'
        return map[y+2][x], x, y+2, :up
      else
        return '', x, y, :done
      end
    else
      raise 'Unknown direction'
    end
  when '-'
    case dir
    when :right
      case map[y][x+1]
      when '-', '+'
        return map[y][x+1], x+1, y, dir
      when '|'
        return map[y][x+2], x+2, y, dir
      when /[A-Z]/
        return map[y][x+1], x+1, y, dir
      else
        return '', x, y, :done
      end
    when :left
      case map[y][x-1]
      when '-', '+'
        return map[y][x-1], x-1, y, dir
      when '|'
        return map[y][x-2], x-2, y, dir
      when /[A-Z]/
        return map[y][x-1], x-1, y, dir
      else
        return '', x, y, :done
      end
    else
      raise 'Unknown direction'
    end
  when /[A-Z]/
    case dir
    when :down
      try_move = map[y-1][x]
      case try_move
      when '|', '+'
        return "", x, y-1, dir
      when '-'
        return "", x, y-2, dir
      when /[A-Z]/
        return try_move, x, y-1, dir
      else
        return '', x, y, :done
      end
    when :up
      try_move = map[y+1][x]
      case try_move
      when '|', '+'
        return "", x, y+1, dir
      when '-'
        return "", x, y+2, dir
      when /[A-Z]/
        return try_move, x, y+1, dir
      else
        return '', x, y, :done
      end
    when :right
      try_move = map[y][x+1]
      case try_move
      when '-', '+'
        return "", x+1, y, dir
      when '|'
        return "", x+2, y, dir
      when /[A-Z]/
        return try_move, x+1, y, dir
      else
        return '', x, y, :done
      end
    when :left
      try_move = map[y][x-1]
      case try_move
      when '-', '+'
        return "", x-1, y, dir
      when '|'
        return "", x-2, y, dir
      when /[A-Z]/
        return try_move, x-1, y, dir
      else
        return '', x, y, :done
      end
    else
      raise 'Unknown direction'
    end
  else
    puts "#{x} #{y}"
    raise 'Invalid state'
  end
end

file = File.open("19_input.txt", "r")
map = []
pos_x = -1
file.each_line do |l|
  row = l.gsub("\n", "").split('')
  pos_x = row.index('|') if pos_x < 0
  map.unshift(row)
end
pos_y = map.length - 1
direction = :down
steps = 1

letters = []
letter = ""
while(direction != :done) do
  letters << letter if letter =~ /[A-Z]/
  old_x = pos_x
  old_y = pos_y
  letter, pos_x, pos_y, direction = move(map, pos_x, pos_y, direction)
  steps += (old_x - pos_x).abs
  steps += (old_y - pos_y).abs
end

# Part 1 - Rank 603
puts letters.join

# Part 2 - Rank 590
puts steps
