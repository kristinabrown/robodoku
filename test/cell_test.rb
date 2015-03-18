require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'

class CellTest < Minitest::Test
  
  def test_it_initializes_with_attributes
    cell = Cell.new(" ", 0, 0)
    assert_equal " ", cell.value
    assert_equal 0,   cell.row_number
    assert_equal 0,   cell.column_number
    assert_equal 1,   cell.square_number
  end
  
  def test_it_can_know_emptieness
    cell = Cell.new(" ", 0, 0)
    assert cell.empty?
  end  
end