file = File.open("08_input.txt", "r")
registers = Hash.new(0)
max = 0

file.each_line do |l|
  l.match(/(\w+) (inc|dec) (-?\d+) if (\w+) ([!<>=]+) (-?\d+)/)
  target = $1
  action = $2
  val = $3.to_i
  source = $4
  cond = $5
  cond_val = $6.to_i

  case cond
  when "=="
    execute = registers[source] == cond_val
  when "!="
    execute = registers[source] != cond_val
  when "<"
    execute = registers[source] < cond_val
  when "<="
    execute = registers[source] <= cond_val
  when ">"
    execute = registers[source] > cond_val
  when ">="
    execute = registers[source] >= cond_val
  else
    raise "unhandled cond #{cond}"
  end

  if execute
    case action
    when "inc"
      registers[target] += val
    when "dec"
      registers[target] -= val
    else
      raise "unhandled action #{action}"
    end
  end

  max = registers[target] if registers[target] > max
end

# Part 1
puts registers.values.max
# Part 2
puts max
