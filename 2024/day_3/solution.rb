=begin

https://adventofcode.com/2024/day/3

=== PROBLEM ===

get the sum of all the valid multiplications from the corrupted memory

=== RULES ===

valid mutlitiplications:
  - numbers are 1-3 digits long
  - numbers are enclosed by left/right parenthesis
  - "mul" is to the left of the left parenthesis
  - must NOT be any spaces

=== BRAINSTORM ===

use a regex?

=end

def mul(num1, num2)
  num1 * num2
end

input = File.open('Advent_of_Code/2024/day_3/input.txt')

products = []

input.each_line do |line|
  multiplications = line.scan(/mul\(\d{1,3}.\d{1,3}\)/)

  multiplications.each do |multiplication|
    arguments = multiplication.match(/mul\((\d+),(\d+)\)/)
    products << mul(arguments[1].to_i, arguments[2].to_i)
  end
end

p products.sum
# => 175700056

# Part 2

input.rewind

active = true

products = []

input.each_line do |line|
  orders = line.scan(/don't\(\)|do\(\)|mul\(\d{1,3},\d{1,3}\)/)

  orders.each do |order|
    if order == "do()"
      active = true
    elsif order == "don't()"
      active = false
    elsif active
      arguments = order.match(/mul\((\d+),(\d+)\)/)
      products << mul(arguments[1].to_i, arguments[2].to_i)
    end
  end
end

p products.sum
# => 71668682
