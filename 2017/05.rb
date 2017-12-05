file = File.open("05_input.txt", "r")
instructions = []
file.each_line do |l|
  instructions << l.strip.to_i
end

def increment(val)
  if val > 3
    # Part 2
    -1
  else
    # Part 1
    1
  end
end

i = 0
count = 0
while(i < instructions.length) do
  instr = instructions[i]
  instructions[i] += increment(instr)
  i += instr
  count += 1
end

puts count
