letters = ('a'..'z').to_a
file = File.open('04_input.txt', 'r')
sum = 0
file.each_line do |l|
  l.match(/([-\w]+)-(\d+)\[(\w+)\]/)
  name = $1
  id = $2.to_i
  check = $3
  counts = Hash.new(0)
  rotated = []
  name.gsub('-', '').split('').each do |c|
    counts[c] += 1
    rotated << letters[(letters.index(c) + id) % letters.length]
  end
  # Part 2
  puts "#{rotated.join}-#{id}" if rotated.join =~ /pole/
  ordered = []
  counts.values.uniq.sort.reverse.each do |n|
    if counts.values.count(n) == 1
      counts.each do |k, v|
        if v == n
          ordered << k
        end
      end
    else
      tied = []
      counts.each do |k, v|
        if v == n
          tied << k
        end
      end
      ordered += tied.sort
    end
  end
  if ordered[0..4].join == check
    sum += id
  end
end
# Part 1
puts sum
