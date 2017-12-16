dances = File.read("16_input.txt").split(',')
@programs = ("a".."p").to_a
# Part 1
n = 1
# Part 2
n = 1000000000
memo = {}
dup = 0
n.times do |i|
  # puts "#{i} - #{@programs.join}"
  memo[i] = @programs.join
  src = @programs.clone
  if !memo["#{src.join}-start"].nil?
    # puts "master skip"
    @programs = memo["#{src.join}-start"].split('')
    dup = i
    break
  end
  dances.each_with_index do |dance, idx|
    mini_src = @programs.clone
    if !memo["#{mini_src.join}#{dance}"].nil?
      # puts "mini skip"
      @programs = memo["#{mini_src.join}#{dance}"].split('')
      next
    end
    dance.match(/(\w)(\w+)(\/(\w+))?/)
    action = $1
    case action
    when "s"
      rot = $2.to_i
      rot.times do
        @programs.unshift(@programs.pop)
      end
    when "x"
      pos1 = $2.to_i
      pos2 = $4.to_i
      val1 = @programs[pos1]
      val2 = @programs[pos2]
      @programs[pos1] = val2
      @programs[pos2] = val1
    when "p"
      val1 = $2
      val2 = $4
      pos1 = @programs.index(val1)
      pos2 = @programs.index(val2)
      @programs[pos1] = val2
      @programs[pos2] = val1
    end
    memo["#{mini_src.join}#{dance}"] = @programs.join
  end
  memo["#{src.join}-start"] = @programs.join
end
# Part 1
puts @programs.join
# Part 2
puts memo[n % dup]
