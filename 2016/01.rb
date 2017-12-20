def next_dir(move, dir)
  case dir
  when :up
    case move
    when 'L'
      :left
    when 'R'
      :right
    else
      raise 'Unknown move'
    end
  when :down
    case move
    when 'L'
      :right
    when 'R'
      :left
    else
      raise 'Unknown move'
    end
  when :right
    case move
    when 'L'
      :up
    when 'R'
      :down
    else
      raise 'Unknown move'
    end
  when :left
    case move
    when 'L'
      :down
    when 'R'
      :up
    else
      raise 'Unknown move'
    end
  else
    raise 'Unknown direction'
  end
end

steps = File.read('01_input.txt').split(', ')

pos_x = 0
pos_y = 0
dir = :up
visited = {}
dist = 0
hq_dist = 0

steps.each do |step|
  step.match(/(R|L)(\d+)/)
  move = $1
  count = $2.to_i
  dir = next_dir(move, dir)
  case dir
  when :up
    count.times do
      pos_y += 1
      if visited[[pos_x, pos_y]] && hq_dist == 0 
        hq_dist = pos_x.abs + pos_y.abs
      end
      visited[[pos_x, pos_y]] = true
    end
  when :down
    count.times do
      pos_y -= 1
      if visited[[pos_x, pos_y]] && hq_dist == 0 
        hq_dist = pos_x.abs + pos_y.abs
      end
      visited[[pos_x, pos_y]] = true
    end
  when :right
    count.times do
      pos_x += 1
      if visited[[pos_x, pos_y]] && hq_dist == 0 
        hq_dist = pos_x.abs + pos_y.abs
      end
      visited[[pos_x, pos_y]] = true
    end
  when :left
    count.times do
      pos_x -= 1
      if visited[[pos_x, pos_y]] && hq_dist == 0 
        hq_dist = pos_x.abs + pos_y.abs
      end
      visited[[pos_x, pos_y]] = true
    end
  else
    raise 'Unknown direction'
  end
  dist = pos_x.abs + pos_y.abs
end

# Part 1
puts dist

# Part 2
puts hq_dist
