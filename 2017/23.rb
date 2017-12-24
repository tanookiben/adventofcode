require 'prime'

instructions = []

file = File.open('23_input.txt', 'r')
file.each_line do |l|
  l.match(/(\w+) ([-\w]) ([-\w]+)/)
  instructions << [$1, $2, $3]
end

def run(instructions, debug)
  registers = Hash.new(0)
  registers['a'] = 1 if debug

  i = 0
  mul_count = 0
  while(i < instructions.length) do
    # Thanks Reddit
    if debug && i == 8
      registers['f'] = Prime.prime?(registers['b']) ? 1 : 0
      i += 16
      next
    end
    a, x, y = instructions[i]
    case a
    when 'set'
      val = y =~ /[-\d]+/ ? y.to_i : registers[y]
      registers[x] = val
    when 'sub'
      val = y =~ /[-\d]+/ ? y.to_i : registers[y]
      registers[x] -= val
    when 'mul'
      val = y =~ /[-\d]+/ ? y.to_i : registers[y]
      registers[x] *= val
      mul_count += 1
    when 'jnz'
      check = x =~ /[-\d]+/ ? x.to_i : registers[x]
      val = y =~ /[-\d]+/ ? y.to_i : registers[y]
      if check != 0
        i += (val)
        next
      end
    else
      raise 'Invalid instruction'
    end
    i += 1
  end

  if debug
    registers['h']
  else
    mul_count
  end
end

# Part 1
puts run(instructions, false)

# Part 2
puts run(instructions, true)
