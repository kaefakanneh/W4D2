require_relative 'piece'


class Board
  attr_accessor :rows
  def initialize
    @rows = Array.new(8) do |row_index|
      Array.new(8) do |column_index|
        case row_index
        when 0, 1
          Piece.new(:white, self, [row_index, column_index])
        when 6, 7
          Piece.new(:black, self, [row_index, column_index])
        else
          nil
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    raise "Trying to move nil piece" if self[start_pos].nil?
    raise "Trying to move to an invalid position" unless valid_pos?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def [](pos)
    row,col = pos
    rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    rows[row][col] = value
  end

  def valid_pos?(pos)
    pos.all? {|coordinate| coordinate.between?(0,7) }
  end


end
