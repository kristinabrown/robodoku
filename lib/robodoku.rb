require_relative 'cell'

class Robodoku
  attr_accessor :puzzle, :solved, :rows, :assigned_puzzle
  attr_reader  :possible

  def initialize(puzzle)
    @puzzle = File.open(puzzle)
    @possible = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @solved = false
  end

  def parse_puzzle
    puzzle_sectioned = []
    puzzle.each_char.each_slice(10) { |section| puzzle_sectioned << section }
    @rows = puzzle_sectioned.select { |section| section[0..-2] }
  end

  def assign_spots(puzzle_sectioned = @rows)
    @assigned_puzzle = 
    puzzle_sectioned.flat_map.with_index do |row, row_number|
       row.map.with_index do |value, column_number|
         Cell.new(value, row_number, column_number)
       end
     end
   end

   def find_empty(puzzle = @assigned_puzzle)
     puzzle.select { |cell| cell.empty? }.sample
   end

   def find_new_possibilities(puzzle_row)
     new_possible = possible.reject do |num|
       puzzle_row.any? do |cell|
         num == cell.value.to_i
       end
     end
    new_possible
  end

   def find_row(puzzle, row_num)
     puzzle.select do |cell|
       cell.row_number == row_num.to_i
     end
   end

   def find_column(puzzle, col_num)
     puzzle.select do |cell|
       cell.column_number == col_num
     end
   end

   def find_square(puzzle, sq_num)
     puzzle.select do |cell|
       cell.square_number == sq_num
     end
   end

   def solve_spot(assigned_puzzle , empty_spot)
     row_number = empty_spot.row_number
     row = find_row(assigned_puzzle, row_number)
     row_possible = find_new_possibilities(row)
     
     column_number = empty_spot.column_number
     column = find_column(assigned_puzzle, column_number)
     column_possible = find_new_possibilities(column)
     
     square_number = empty_spot.square_number
     square = find_square(assigned_puzzle, square_number)
     square_possible = find_new_possibilities(square)
     
     new_value = (row_possible & column_possible & square_possible)
     
     new_value.count == 1 ? new_value.join : " "  
   end

   def check_solution(puzzle)
     puzzle.none? {|cell| cell.value == " "} ? @solved = true : @solved = false
   end

   def solve_puzzle(assigned_puzzle = @assigned_puzzle)
     check_solution(assigned_puzzle)
     if @solved == false
       empty_spot = find_empty(assigned_puzzle)
       empty_spot.value = solve_spot(assigned_puzzle, empty_spot)
       solve_puzzle(assigned_puzzle)
     else
       print_out_puzzle(assigned_puzzle)
     end
   end

   def print_out_puzzle(assigned_puzzle)
     assigned_puzzle.map do |cell|
       cell.value
     end.join
   end
end


robo = Robodoku.new('./puzzles/puzzle6.txt')
sectioned = robo.parse_puzzle
assigned = robo.assign_spots(sectioned)

puts robo.solve_puzzle(assigned)
