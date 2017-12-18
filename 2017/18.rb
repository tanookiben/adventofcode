class Program
  def initialize(id, instructions)
    @instructions = instructions
    @registers = Hash.new(0)
    @registers["p"] = id
    @index = 0
    @sent = 0
  end

  def run(rcv)
    # puts "starting with #{@index}"
    freq = []

    while(@index >= 0) do
      instr = @instructions[@index]
      instr.match(/(\w+) (\w)( ([-\w]+))?/)

      reg = $2
      val = $4

      case $1
      when "snd"
        @sent += 1
        if reg =~ /[-\d]+/
          freq << reg.to_i
        else
          freq << @registers[reg]
        end
      when "set"
        if val =~ /[-\d]+/
          @registers[reg] = val.to_i
        else
          @registers[reg] = @registers[val]
        end
      when "add"
        if val =~ /[-\d]+/
          @registers[reg] += val.to_i
        else
          @registers[reg] += @registers[val]
        end
      when "mul"
        if val =~ /[-\d]+/
          @registers[reg] *= val.to_i
        else
          @registers[reg] *= @registers[val]
        end
      when "mod"
        if val =~ /[-\d]+/
          @registers[reg] = @registers[reg] % val.to_i
        else
          val = @registers[val]
          @registers[reg] = @registers[reg] % val
        end
      when "rcv"
        if rcv.length > 0
          @registers[reg] = rcv.shift
        else
          break
        end
      when "jgz"
        # Fuck me this one bug took me literally 3 hours to fix
        if (reg.to_i > 0) || (@registers[reg] > 0)
          if val =~ /[-\d]+/
            @index += val.to_i
          else
            @index += @registers[val]
          end
          next
        end
      end
      @index += 1
    end
    return freq
  end

  def sent
    @sent
  end

  def regs
    @registers
  end
end

instructions = File.read("18_input.txt").split("\n")

program0 = Program.new(0, instructions)

# Part 1
program0_rcv = []
program1_rcv = program0.run(program0_rcv)
puts program1_rcv.last

# Part 2
program1 = Program.new(1, instructions)
program0_rcv = program1.run(program1_rcv)
while(program0_rcv.length != 0) do
  program1_rcv = program0.run(program0_rcv)
  if program1_rcv.length == 0
    break
  end
  program0_rcv = program1.run(program1_rcv)
end
puts program1.sent

