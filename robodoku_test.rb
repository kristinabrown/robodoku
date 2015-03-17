require 'minitest/autorun'
require 'minitest/pride'
require_relative 'robodoku'

class RobodokuTest < Minitest::Test

  def test_it_can_take_a_string_and_make_it_an_array
    puzzle = ("1 3 4 567 8 9 8")
    robo = Robodoku.new(puzzle)
    assert_equal 15, robo.puzzle.count
  end

  def test_it_can_take_a_puzzle_from_a_file
    skip
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    assert_equal 3, robo.puzzle
  end

  def test_it_can_parse_puzzle
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    parsed_puzzle = robo.parse_puzzle
    assert_equal 9, parsed_puzzle.count
  end

  def test_it_can_assign_row_and_columns
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assert_equal 90, robo.assign_spots(sectioned).count
  end

  def test_it_can_find_empty_spots
    skip
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)
    assert_equal 1, robo.find_empty(assigned).count
  end

  def test_it_can_find_new_possibilities
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)
    empty_spots = robo.find_empty(assigned)
    row_number = robo.find_row_number(empty_spots)
    row = robo.find_row(assigned, row_number)

    assert_equal [6], robo.find_new_possibilities(row)
  end

  def test_it_can_analyze_one_row
    skip
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)

    assert_equal 6, robo.solve_spot(assigned).inspect
  end

  def test_it_can_solve_a_puzzle
    skip
    puzzle = File.open('./puzzle.txt')
    robo = Robodoku.new(puzzle)
    sectioned = robo.parse_puzzle
    assigned = robo.assign_spots(sectioned)

    assert_equal 90, robo.solve_puzzle(assigned)
  end

end
