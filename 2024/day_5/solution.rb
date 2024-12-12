=begin

=== PROBLEM ===

Baseed on the given printing order, determine which updates are in the correct order

Rules:
  - page order rules are in the format X|Y
    - so X must be printed sometime before Y
  - updates are lists of page numbers
  - middle number:
    - [1, 2, 3] --> 2 is the middle number
    - [4, 5, 6, 7] --> ...5 or 6?

=== DATA ===

input:
  - page order rules
  - updates of page numbers
  (input will be a file object to be parsed)
output:
  - the sum of the middle number of all the correctly ordered updates

=== BRAINSTORM ===

first, parse the file
  - chomp off \n from each line
  - put each line into an array

gather the printing order rules
  - perhaps a hash
    - key: page number
    - values: array of page numbers that come before
  - iterate over the files lines
    - if the line has "|"
      - split into an array
      - array[0] becomes the key, array[1] is added to the array of that key
    END
  END

gather the correctly ordered updates
  - iterate over the file lines
    - if the line contains any ','
      - split into an array of numbers
      - iterate over the numbers
       - if all the numbers behind the current number are inside the value array of rules[current_num]
         - add it to the correctly ordered updates
      END
    END
  END
  
determining correct orders
  - iterate over the indicies of the update (current_idx)
    - iterate over the numbers from 0 to current idx (preceeding_idx)
      - check if the number at update[preceeding_idx] exists in rules[current_idx]

  get the sum of all the middle numbers of correctly ordered updates
  - iterate over the correctly ordered updates
    - determine the middle number
    - add it to the sum
  END
  - return that sum

organize solution into classes?
  - Rules
  - Updates
  - 

=== DEBUG ===

If a number does not have a rule, then the order does not matter?

Need to check if the numbers ahead are ok too, not only the previous ones

maybe ditch the classes

=end

=begin
class FileParser
  attr_reader :array

  def initialize(raw_file)
    @array = parse(raw_file)
  end

  private

  def parse(raw_file)
    file_arr = []

    raw_file.each_line do |line|
      file_arr << line.chomp
    end

    file_arr
  end
end

class Rules
  attr_reader :previous_numbers, :following_numbers

  def initialize(parsed_file)
    @previous_numbers = {}
    @following_numbers = {}
    make_rules(parsed_file)
  end

  private

  def make_rules(parsed_file)
    parsed_file.each do |line|
      if line.include?('|')
        arr = line.split('|').map(&:to_i)
        following_num, preceeding_num = arr[0], arr[1]

        if previous_numbers[following_num] == nil
          self.previous_numbers[following_num] = [preceeding_num]
        else
          self.previous_numbers[following_num] << preceeding_num
        end

        if following_numbers[preceeding_num] == nil
          self.following_numbers[preceeding_num] = [following_num]
        else
          self.following_numbers[preceeding_num] << following_num
        end
      end
    end
  end
end

class Updates
  attr_reader :list, :rules

  def initialize(parsed_file, rules)
    @list = parse_updates(parsed_file)
    @rules = rules
  end

  def correct_ones
    list.select do |update|
      correctly_ordered?(update)
    end
  end

  private

  def parse_updates(file)
    updates = []
    
    file.each do |line|
      if line.include?(',')
        update = line.split(',').map(&:to_i)
        updates << update
      end
    end

    updates
  end

  def correctly_ordered?(update)
    update.all? do |num|
      all_previous_nums?(num) && all_following_nums?(num)
    end
  end
end

input = File.open('Advent_of_Code/2024/day_5/input.txt')

parsed_file = FileParser.new(input).array
rules = Rules.new(parsed_file)
=end

def parse(file)
  file_arr = []

  file.each_line do |line|
    file_arr << line.chomp
  end

  file_arr
end

def get_rules(file)
  before_rules = {}
  after_rules = {}
  
  file.each do |line|
    if line.include?('|')
      arr = line.split('|').map(&:to_i)
      following_num, preceeding_num = arr[0], arr[1]

      if before_rules[following_num] == nil
        before_rules[following_num] = [preceeding_num]
      else
        before_rules[following_num] << preceeding_num
      end

      if after_rules[preceeding_num] == nil
        after_rules[preceeding_num] = [following_num]
      else
        after_rules[preceeding_num] << following_num
      end
    end
  end

  [before_rules, after_rules]
end

def get_updates(file)
  updates = []
    
  file.each do |line|
    if line.include?(',')
      update = line.split(',').map(&:to_i)
      updates << update
    end
  end

  updates
end

def correct?(update, before_rules, after_rules)  
  (0...update.size).all? do |idx|
    prev_nums = update[0..idx - 1]
    following_nums = update[idx + 1..-1]

    if idx == 0
      following_nums.all? do |following_num|
        after_rules[update[idx]].include?(following_num)
      end
    elsif idx == update.size - 1
      prev_nums.all? do |prev_num|
        before_rules[update[idx]].include?(prev_num)
      end
    else
      prev_correct = (prev_nums.all? do |prev_num|
        before_rules[update[idx]].include?(prev_num)
      end)

      following_correct = (following_nums.all? do |following_num|
        after_rules[update[idx]].include?(following_num)
      end)

      prev_correct && following_correct
    end
  end
end

input = File.open('Advent_of_Code/2024/day_5/input.txt')
parsed_input = parse(input)

before_rules, after_rules = get_rules(parsed_input)
updates = get_updates(parsed_input)

correct_updates = updates.select do |update|
  correct?(update, before_rules, after_rules)
end

p correct_updates


