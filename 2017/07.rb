class Program
  def initialize(name, weight)
    @name = name
    @weight = weight
    @children = []
  end

  # def name=(val)
  #   @name = val
  # end
  def name
    @name
  end
  # def weight=(val)
  #   @weight = val
  # end
  def weight
    @weight
  end
  def parent=(val)
    @parent = val
  end
  def parent
    @parent
  end
  def add_child(val)
    @children << val
  end
  def children
    @children
  end

  def total_weight
    @total_weight = @weight
    @children.each do |child|
      @total_weight += child.total_weight
    end
    @total_weight
  end

  def balanced?
    weights = @children.map(&:total_weight)
    weights.all? { |w| w == weights[0] }
  end
end

programs = {}
has_children = {}

file = File.open("07_input.txt", "r")
file.each_line do |l|
  l.strip.match(/(\w+) \((\d+)\)/)
  name = $1
  weight = $2.to_i
  programs[name] = Program.new(name, weight)
  l.strip.match(/-> ([\w, ]+)/)
  children = $1
  if !children.nil?
    has_children[name] = children.split(', ')
  end
end
has_children.each do |name, children|
  children.each do |child|
    parent_program = programs[name]
    child_program = programs[child]
    parent_program.add_child(child_program)
    child_program.parent = parent_program
  end
end

programs.each do |name, program|
  if program.parent.nil?
    @root = program
    # Part 1
    puts name
  end
end

node = @root
while (!(node.children.all? { |c| c.balanced?})) do
  node.children.each do |n|
    if !n.balanced?
      node = n
      break
    end
  end
end

children = node.children
weights = children.map(&:total_weight)
required_diff = weights.uniq.inject(:-).abs
weights.each_with_index do |w, i|
  if weights.count(w) == 1
    # Part 2
    puts children[i].weight - required_diff
  end
end
