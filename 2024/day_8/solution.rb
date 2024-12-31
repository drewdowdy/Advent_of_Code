=begin

=== PROBLEM ===

given a map of antenas, determine how many antinodes are possible on the map.

antinodes are created when two antenas of the same frequency are in line with each other. the created antinodes are the same distance from their respective antenas 

antenna - lowercase letter, uppercase letter, or digit
antinode - hash mark

=== BRAINSTORM ===

iterate over each line
  iterate over each char
    if the current char is an antenna
      find the next matching antenna ahead in the map
        determine the distance 
        if the mark at the distance from antenna1 and antenna2 is '.'
          replace with '#'


=end

file_name = 'Advent_of_Code/2024/day_8/input.txt'
parsed_file = File.readlines(file_name, chomp: true)
row_size = parsed_file[0].size

def is_antenna?(row, column, file)
  valid_antennas = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
  valid_antennas.include?(file[row][column])
end

def find_next_antenna_from(start_row, col, parsed_file)

end

def solve(parsed_file)
  (0...parsed_file.size).each do |row|
    (0...row_size).each do |col|
      if is_antenna?(row, col, parsed_file)
        next_antenna = find_next_antenna_from(row, col, parsed_file)
      end
    end
  end
end

solve(parsed_file)


