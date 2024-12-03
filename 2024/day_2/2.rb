=begin

--- Day 2: Red-Nosed Reports ---
Fortunately, the first location The Historians want to search isn't a long walk from the Chief Historian's office.

While the Red-Nosed Reindeer nuclear fusion/fission plant appears to contain no sign of the Chief Historian, the engineers there run up to you as soon as they see you. Apparently, they still talk about the time Rudolph was saved through molecular synthesis from a single electron.

They're quick to add that - since you're already here - they'd really appreciate your help analyzing some unusual data from the Red-Nosed reactor. You turn to check if The Historians are waiting for you, but they seem to have already divided into groups that are currently searching every corner of the facility. You offer to help with the unusual data.

The unusual data (your puzzle input) consists of many reports, one report per line. Each report is a list of numbers called levels that are separated by spaces. For example:

7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
This example data contains six reports each containing five levels.

The engineers are trying to figure out which reports are safe. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:

The levels are either all increasing or all decreasing.
Any two adjacent levels differ by at least one and at most three.
In the example above, the reports can be found safe or unsafe by checking those rules:

7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.
So, in this example, 2 reports are safe.

Analyze the unusual data from the engineers. How many reports are safe?

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

=begin

--- Part Two ---
The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the Problem Dampener.

The Problem Dampener is a reactor-mounted module that lets the reactor safety systems tolerate a single bad level in what would otherwise be a safe report. It's like the bad level never happened!

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

7 6 4 2 1: Safe without removing any level.
1 2 7 8 9: Unsafe regardless of which level is removed.
9 7 6 2 1: Unsafe regardless of which level is removed.
1 3 2 4 5: Safe by removing the second level, 3.
8 6 4 4 1: Safe by removing the third level, 4.
1 3 6 7 9: Safe without removing any level.
Thanks to the Problem Dampener, 4 reports are actually safe!

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?

=== PROBLEM ===

with a dampener, we can remove a single level from the report
with any 1 level removed, is the new report safe?

=== BRAINSTORM ===

need to iterate over all combinations of the report with 1 item removed

create all combinations
if any combination is also all safely incrementing, AND is increasing or decreasing, then

=end

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
