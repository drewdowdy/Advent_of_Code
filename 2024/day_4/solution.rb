=begin

=== PROBLEM ===

find all instances of XMAS in the crossword puzzle

Rules:
- correct words can be horizontal, vertical, diagonal, written backwards, or even overlapping other words

=== DATA ===

input: an array of strings
  - each line is the same length

=== BRAINSTORM ===

iterate over the indices?

once X is captured, how to check all the spaces around it?

make separate methods that check for each direction:
  up, down, left, right, up-left, up-right, down-left, down-right

parse the input into a matrix?
  use row num and column num

up_match?(row, col)
  increment from row down to the size of the match_word
  check if the letter at each increment matches the letter in the match_word

=== ALGORITHM ===

=== DEBUG ===

=end

class WordSearch
  attr_reader :puzzle, :match_word

  def initialize(puzzle, match_word)
    @puzzle = to_array(puzzle)
    @match_word = match_word
  end

  def solve
    number_of_matches = 0

    puzzle.each_with_index do |line, row|
      (0...line.size).each do |col|
        increase = [
          up_match?(row, col),
          down_match?(row, col),
          forward_match?(row, col),
          backward_match?(row, col),
          up_left_match?(row, col),
          up_right_match?(row, col),
          down_left_match?(row, col),
          down_right_match?(row, col)
        ].count(true) 
        number_of_matches += increase
      end
    end
  
    number_of_matches
  end

  private

  def to_array(puzzle)
    parsed_puzzle = []

    puzzle.each_line do |line|
      parsed_puzzle << line.chomp
    end

    parsed_puzzle
  end

  def up_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_row = row - idx
      return false unless in_bounds?(current_row, col) && puzzle[current_row][col] == match_letter
    end

    true
  end
  
  def down_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_row = row + idx
      return false unless in_bounds?(current_row, col) && puzzle[current_row][col] == match_letter
    end

    true
  end
  
  def forward_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_column = col + idx
      return false unless in_bounds?(row, current_column) && puzzle[row][current_column] == match_letter
    end

    true
  end
  
  def backward_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_column = col - idx
      return false unless in_bounds?(row, current_column) && puzzle[row][current_column] == match_letter
    end

    true
  end
  
  def up_left_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_row = row - idx
      current_column = col - idx
      return false unless in_bounds?(current_row, current_column) && puzzle[current_row][current_column] == match_letter
    end

    true
  end
  
  def up_right_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_row = row - idx
      current_column = col + idx
      return false unless in_bounds?(current_row, current_column) && puzzle[current_row][current_column] == match_letter
    end

    true
  end
  
  def down_left_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_row = row + idx
      current_column = col - idx
      return false unless in_bounds?(current_row, current_column) && puzzle[current_row][current_column] == match_letter
    end

    true
  end
  
  def down_right_match?(row, col)
    match_word.each_char.with_index do |match_letter, idx|
      current_row = row + idx
      current_column = col + idx
      return false unless in_bounds?(current_row, current_column) && puzzle[current_row][current_column] == match_letter
    end

    true
  end

  def in_bounds?(row, col)
    return false if [puzzle[row], puzzle[col]].include?(nil)
    (0..puzzle.size).include?(row) && (0..puzzle[0].size).include?(col)
  end
end

puzzle = File.open("Advent_of_Code/2024/day_4/input.txt")
p WordSearch.new(puzzle, 'XMAS').solve
# => 2401

# Part 2
