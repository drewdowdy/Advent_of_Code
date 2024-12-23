=begin

=== PROBELM ===

write a program that determines the how many unique places the path of the guard has

Rules:
  - if no obstical, go forward (up)
  - else, turn 90 degrees clockwise
  - if the guard reaches the edge of the map, it's finished

=== BRAINSTORM ===

store map as an array of strings
  arr[1][2] -> row1, col2

find the ^, >, v, <
  if it's ^ at arr[r][c]
    if arr[r - 1][c] is '#'
      change arr[r][c] to '>'
    else
      change arr[r][x] to 'X'
      change arr[r - 1][c] to '^'
  

=end

class Map
  attr_reader :array
  attr_accessor :guard_direction, :guard_location, :next_location

  DIRECTIONS = ['^', '>', 'v', '<']
  NEXT_LOCATIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  OBSTACLE = '#'

  def initialize(array)
    @array = array
    @guard_direction = 0
    @next_location = 0
    @guard_location = find_guard
  end

  def find_guard
    (0...array.size).each do |row|
      (0...array[row].size).each do |column|
        return [row, column] if array[row][column] == DIRECTIONS[guard_direction]
      end
    end
  end

  def route_finished?
    array[next_spot[0]] == nil || array[next_spot[0]][next_spot[1]] == nil
  end

  def advance_guard
    if can_advance?
      update_guard_position
    else
      self.guard_direction = (self.guard_direction + 1) % DIRECTIONS.size
      self.next_location = (self.next_location + 1) % NEXT_LOCATIONS.size
    end
  end

  def update_guard_position
    array[guard_location[0]][guard_location[1]] = 'X'
    array[next_spot[0]][next_spot[1]] = DIRECTIONS[guard_direction]
    self.guard_location = next_spot
  end

  def next_spot
    [
      guard_location[0] + NEXT_LOCATIONS[next_location][0],
      guard_location[1] + NEXT_LOCATIONS[next_location][1]
    ]
  end

  def can_advance?
    return false if route_finished?
    array[next_spot[0]][next_spot[1]] != OBSTACLE
  end

  def how_many_positions
    x_count = 0

    array.each do |row|
      x_count += row.count('X')
    end

    x_count
  end

  def display
    array.each do |row|
      puts row
    end
  end

  def update_last_location
    array[guard_location[0]][guard_location[1]] = 'X'
  end
end

def parse(file)
  file_arr = []

  file.each_line do |line|
    file_arr << line.chomp
  end

  file_arr
end

input = File.open('Advent_of_Code/2024/day_6/input.txt')
array = parse(input)

map = Map.new(array)

until map.route_finished?
  map.display
  map.advance_guard
  sleep 0.001
  system 'clear'
end

map.update_last_location
map.display

p map.how_many_positions

# Part 2

class Map2
  attr_reader :array
  attr_accessor :guard_direction, :guard_location, :next_location

  DIRECTIONS = ['^', '>', 'v', '<']
  NEXT_LOCATIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  OBSTACLE = '#'
  BLOCKAGE = 'O'

  def initialize(array)
    @array = array
    @guard_direction = 0
    @next_location = 0
    @guard_location = find_guard
  end

  def find_guard
    (0...array.size).each do |row|
      (0...array[row].size).each do |column|
        return [row, column] if array[row][column] == DIRECTIONS[guard_direction]
      end
    end
  end

  def route_finished?
    array[next_spot[0]] == nil || array[next_spot[0]][next_spot[1]] == nil
  end

  def advance_guard
    if can_advance?
      update_guard_position
    else
      self.guard_direction = (self.guard_direction + 1) % DIRECTIONS.size
      self.next_location = (self.next_location + 1) % NEXT_LOCATIONS.size
    end
  end

  def update_guard_position
    array[guard_location[0]][guard_location[1]] = 'X'
    array[next_spot[0]][next_spot[1]] = DIRECTIONS[guard_direction]
    self.guard_location = next_spot
  end

  def next_spot
    [
      guard_location[0] + NEXT_LOCATIONS[next_location][0],
      guard_location[1] + NEXT_LOCATIONS[next_location][1]
    ]
  end

  def can_advance?
    return false if route_finished?
    array[next_spot[0]][next_spot[1]] != OBSTACLE
  end

  def how_many_positions
    x_count = 0

    array.each do |row|
      x_count += row.count('X')
    end

    x_count
  end

  def display
    array.each do |row|
      puts row
    end
  end

  def update_last_location
    array[guard_location[0]][guard_location[1]] = 'X'
  end

  def can_loop?

  end
end

# until map.route_finished?
#   map.advance_guard

#   if map.can_loop?
#     add_blockage
#   end
# end
