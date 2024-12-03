=begin

https://adventofcode.com/2024/day/1

=== PROBLEM ===

What is the total distance between the two lists?

=== RULES ===

- in ascending order, find the differences between the numbers of the two lists and sum those differences
- lists are the same size (same number of entries)
- numbers may repeat

=== BRAINSTORM ===

- organize numbers into two arrays (arr1, arr2)
- sort the two arrays into ascending order
- iterate over the a range that is the indices (idx)
  - get the absolute value from arr1[idx] and arr2[idx]
  - put that value into a new array (arr3)
- get the sum of arr3

- the lists are so long...
  - create a method that makes the lists

=end

input = File.open('Advent_of_Code/2024/day_1/input.txt')
item_list = File.read(input).split.map(&:to_i)

list1 = []
list2 = []

(0..(item_list.size - 1)).each do |idx|
  idx.even? ? list1 << item_list[idx] : list2 << item_list[idx]
end

sorted_list1 = list1.sort
sorted_list2 = list2.sort

distances = (0..999).map do |idx|
  (sorted_list1[idx] - sorted_list2[idx]).abs
end

distances.sum
# 3574690

# Part 2

input.rewind

list1 = []
list2 = []

(0..(item_list.size - 1)).each do |idx|
  idx.even? ? list1 << item_list[idx] : list2 << item_list[idx]
end

similarity_score = 0

list1.each do |num|
  score_increase = num * list2.count(num)
  similarity_score += score_increase
end

p similarity_score
# => 22565391
