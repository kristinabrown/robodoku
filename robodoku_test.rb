require 'minitest/autorun'
require 'minitest/pride'
require_relative 'robodoku'

class RobodokuTest < Minitest::Test

  def test_it_can_take_a_puzzle_from_a_file
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    assert_equal 90, robo.puzzle.each_char.count
  end

  def test_it_can_parse_puzzle
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    parsed_puzzle = robo.parse_puzzle
    assert_equal 9, parsed_puzzle.count
  end

  def test_it_can_assign_row_and_columns
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assert_equal 90, robo.assign_spots(sectioned).count
  end

  def test_it_can_find_empty_spots
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)
    assert_equal " ", robo.find_empty(assigned).value
  end

  def test_it_can_find_new_possibilities
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)
    empty_spot = robo.find_empty(assigned)
    row_number = empty_spot.row_number
    row = robo.find_row(assigned, row_number)

    assert_equal [6], robo.find_new_possibilities(row)
  end

  def test_it_can_analyze_one_row
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)

    assert_equal 6, robo.solve_spot(assigned).inspect
  end

  def test_it_can_solve_a_puzzle
    puzzle = File.open('./puzzles/puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)
    robo.solve_puzzle(assigned).chars

    assert_equal 90, robo.solve_puzzle(assigned).chars.count
  end
end
