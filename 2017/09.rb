class Group
  def initialize(score)
    @score = score
  end
  def score
    @score
  end
end

input = File.read("09_input.txt").strip
sanitized = input.gsub(/!./, '')
chars = sanitized.split('')

groups = []
tracking = []

garbage = false
count = 0
chars.each do |c|
  case c
  when "{"
    if !garbage 
      tracking << Group.new(tracking.length + 1)
    else
      count += 1
    end
  when "}"
    if !garbage
      groups << tracking.pop
    else
      count += 1
    end
  when "<"
    if !garbage
      garbage = true
    else
      count += 1
    end
  when ">"
    if garbage
      garbage = false
    end
  else
    if garbage
      count += 1
    end
  end
end

# Part 1
puts groups.map(&:score).inject(:+)
# Part 2
puts count
