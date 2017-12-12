class Program
  def initialize(id)
    @id = id
    @reachable = []
  end

  def id
    @id
  end

  def add_path(id)
    if id != @id
      @reachable << id
      @reachable.uniq!
    end
  end

  def reachable
    @reachable
  end
end

def find_group(programs, target)
  visited = {}
  reachable = [target]
  while(reachable.length > 0) do
    visit = reachable.shift
    if visited[visit].nil?
      visited[visit] = true
      program = programs[visit]
      reachable += program.reachable
    end
  end
  return visited.keys
end

programs = {}

file = File.open("12_input.txt", "r")
file.each_line do |l|
  l.strip.match(/(\d+) \<-\> ([\d, ]*)/)
  id = $1
  paths = $2.split(', ')

  parent = programs[id]
  if parent == nil 
    parent = Program.new(id)
    programs[id] = parent
  end

  paths.each do |path_id|
    child = programs[path_id]
    if child == nil
      child = Program.new(path_id)
    end
    parent.add_path(path_id)
    child.add_path(id)
  end
end

# Part 1
puts find_group(programs, "0").length

# Part 2
groups = {}
programs.each do |id, program|
  group = find_group(programs, id)
  hashed = group.sort.join('-')
  if groups[hashed].nil?
    groups[hashed] = hashed
  end
end
puts groups.keys.length
