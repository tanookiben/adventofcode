class Wall
  def initialize(depth, range)
    @depth = depth
    @range = range
  end

  def caught_at(elapsed)
    elapsed % ((@range -1) * 2) == 0
  end

  def severity
    @depth * @range
  end

  def severity_at(elapsed)
    if caught_at(elapsed)
      severity
    else
      0
    end
  end
end

file = File.open("13_input.txt", "r")
firewall = {}
layers = 0
file.each_line do |l|
  l.strip.match(/(\d+): (\d+)/)
  firewall[$1.to_i] = Wall.new($1.to_i, $2.to_i)
  layers = $1.to_i
end

# Part 1
severity = []
(0..layers).each do |i|
  wall = firewall[i]
  if !wall.nil?
    severity << wall.severity_at(i) if wall.caught_at(i)
  end
end
puts "#{severity.inject(:+)}"

# Part 2
elapsed = 0
while(true) do
  severe = []
  firewall.each do |i, w|
    severe << i if w.caught_at(i + elapsed)
  end
  break if severe.length == 0
  elapsed += 1
end
puts elapsed
