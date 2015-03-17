class Cell
  attr_accessor :value
  attr_reader :row_number, :column_number, :square_number

  def initialize(value, row_number, column_number)
    @value = value
    @row_number = row_number
    @column_number = column_number
    @square_number = calc_square(row_number, column_number)
  end

  def calc_square(row, column)
    row/3 * 3 + 1 + column/3
  end
end