=begin

=== PROBLEM ===

Given a result and a list of numbers, determine what operators should go between the numbers to return the result. Return the sum of all the results that are possible

=== BRAINSTORM ===

#eval(String) -> returns the evaluation of string as if it were integers with operators

store the result as integer
  use #split(': ')
  assign result and original to first and last of the split array
make all string combinations of operators
iterate over the combinations with #eval
  compare if the current evaluation equals the result

=end

file_name = 'Advent_of_Code/2024/day_7/input.txt'
parsed_file = File.readlines(file_name, chomp: true)

OPERATORS = %w(+ *)

def calculate(sequence, combo)
  result = sequence.first.to_i

  sequence[1..].each_with_index do |num, index|
    operator = combo[index]

    case operator
    when '+'
      result += num.to_i
    when '*'
      result *= num.to_i
    end
  end

  result
end

def solve(parsed_file)
  correct_values = []

  parsed_file.each do |line|
    arr = line.split(': ')
    value, sequence = arr.first.to_i, arr.last.split

    OPERATORS.repeated_permutation(sequence.size - 1) do |operator_combo|
      if calculate(sequence, operator_combo) == value
        correct_values << value 
        break
      end
    end
  end

  puts correct_values.sum
end

solve(parsed_file)

# Part 2

NEW_OPERATORS = %w(+ * ||)

def calculate_pt_2(sequence, combo)
  result = sequence.first.to_i

  sequence[1..].each_with_index do |num, index|
    operator = combo[index]

    case operator
    when '+'
      result += num.to_i
    when '*'
      result *= num.to_i
    when '||'
      result = (result.to_s + num.to_s).to_i
    end
  end

  result
end

def solve_pt_2(parsed_file)
  correct_values = []

  parsed_file.each do |line|
    arr = line.split(': ')
    value, sequence = arr.first.to_i, arr.last.split

    NEW_OPERATORS.repeated_permutation(sequence.size - 1) do |operator_combo|
      if calculate_pt_2(sequence, operator_combo) == value
        correct_values << value 
        break
      end
    end
  end

  puts correct_values.sum
end

solve_pt_2(parsed_file)
