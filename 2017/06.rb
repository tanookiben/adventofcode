banks = File.read("06_input.txt").strip.split(/\s/).map(&:to_i)
visited = Hash.new(0)
visited[banks.join] = 1
count = 1
while(true) do
  max = banks.max
  start = banks.index(max)  
  num = banks[start]
  banks[start] = 0
  while(num > 0) do
    start += 1
    banks[start%banks.length] += 1
    num -= 1
  end
  if visited[banks.join] > 0
    break
  end
  visited[banks.join] = count
  count += 1
end
# Part 1
puts count
# Part 2
puts count - visited[banks.join]
