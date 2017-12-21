class Point
  def initialize(pos, vel, acc)
    pos_split = pos.split(',').map(&:to_i)
    @pos_x = pos_split[0]
    @pos_y = pos_split[1]
    @pos_z = pos_split[2]
    vel_split = vel.split(',').map(&:to_i)
    @vel_x = vel_split[0]
    @vel_y = vel_split[1]
    @vel_z = vel_split[2]
    acc_split = acc.split(',').map(&:to_i)
    @acc_x = acc_split[0]
    @acc_y = acc_split[1]
    @acc_z = acc_split[2]
  end

  def tick
    @vel_x += @acc_x
    @vel_y += @acc_y
    @vel_z += @acc_z
    @pos_x += @vel_x
    @pos_y += @vel_y
    @pos_z += @vel_z
  end

  def destroy
    @destroyed = true
  end

  def destroyed?
    @destroyed
  end

  def dist
    @pos_x.abs + @pos_y.abs + @pos_z.abs
  end

  def pos
    "<#{@pos_x},#{@pos_y},#{@pos_z}>"
  end
end

points = []
file = File.open('20_input.txt', 'r')
file.each_line do |l|
  l.match(/p=\<([-,\d]+)\>, v=\<([-,\d]+)\>, a=\<([-,\d]+)\>/)
  points << Point.new($1, $2, $3)
end

1000.times do
  points.map(&:tick)
  state = {}
  points.each do |p|
    next if p.destroyed?
    state[p.pos] ||= []
    state[p.pos] << p
  end
  state.each do |loc, pts|
    pts.map(&:destroy) if pts.length > 1
  end
end

# Part 1
dists = points.map(&:dist)
puts dists.index(dists.min)

# Part 2
valid = points.select { |p| !p.destroyed? }
puts valid.count
