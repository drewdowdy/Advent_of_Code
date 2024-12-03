=begin

https://adventofcode.com/2024/day/2

=== PROBLEM ===

return the number of lines that are considered "safe"

=== RULES ===

- a line is safe when the increase between all of the numbers in the line is only 1 OR 2 OR 3
- a line is unsafe if there is NO increase between levels
- a line is unsafe when there is a decrease

=== BRAINSTORM ===

create a counter
read each line of the file
  - convert each line to an array of numbers
  - increment the counter if ALL the numbers increase in a "safe" way
return the counter

how to determine "safe" level increases?
  - iterate over the report
    - range of indices (from 0 to -2)
  - check the number @ current index and at following index
  - the absolute difference of those numbers should be 1, 2, OR 3

=== DEBUG ===

- the numbers in the sequence can be increasing OR decreasing
  - fix: determine if the sequence is increasing or decreasing BEFORE checking all the elements

=end

def parse(line)
  line.split.map(&:to_i)
end

def increasing_or_decreasing?(report)
  report.sort == report || report.sort.reverse == report
end

def safe_increment?(item1, item2)
  change = (item1 - item2).abs
  [1, 2, 3].include?(change)
end

def is_safe?(report)
  if increasing_or_decreasing?(report)
    (0..(report.size - 2)).all? do |idx|
      safe_increment?(report[idx], report[idx + 1])
    end
  else
    false
  end
end

safe_report_num = 0

input = File.open('Advent_of_Code/2024/day_2/input.txt')

input.each_line do |line|
  report = parse(line)
  safe = is_safe?(report)
  safe_report_num += 1 if safe
end

input.close

p safe_report_num
# => 332

# Part 2

def one_level_removed_combos(report)
  combos = []
  
  (0..report.size - 1).each do |idx|
    copy = report.dup
    copy.delete_at(idx)
    combos << copy
  end
  
  combos
end

new_safe_report_num = 0

input = File.open('Advent_of_Code/2024/day_2/input.txt')

input.each_line do |line|
  report = parse(line)

  safe = is_safe?(report) || one_level_removed_combos(report).any? { |report| is_safe?(report) }

  new_safe_report_num += 1 if safe
end

p new_safe_report_num
# => 398
