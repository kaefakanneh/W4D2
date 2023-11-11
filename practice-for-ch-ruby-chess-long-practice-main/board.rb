# require_relative 'pieces/piece'
# require_relative 'pieces/NullPiece'

class Board
  attr_accessor :rows

  SYMBOL_PIECES = { ♜:Rook, ♞:Knight, ♝:Bishop, ♛:Queen, ♚:King, ♟:Pawn }

  def initialize
    pieces = %i(♜ ♞ ♝)
    pieces += %i(♛ ♚) + pieces.reverse

    @rows = Array.new(8) do |row_index|
      Array.new(8) do |column_index|
        case row_index
        when 0
          SYMBOL_PIECES[pieces[column_index]].new(:white, self, [row_index, column_index])
        when 1
          Pawn.new(:white, self, [row_index, column_index])
        when 6
          Pawn.new(:black, self, [row_index, column_index])
        when 7
          SYMBOL_PIECES[pieces[column_index]].new(:black, self, [row_index, column_index])
        else
          NullPiece.instance
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    raise 'Trying to move nil piece' if self[start_pos].nil?
    raise 'Trying to move to an invalid position' unless valid_pos?(end_pos)
    return false unless self[start_pos].moves.include?(end_pos)

    self[start_pos].pos = end_pos
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    true
  end

  def [](pos)
    row, col = pos
    rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    rows[row][col] = value
  end

  def valid_pos?(pos)
    pos.all? { |coordinate| coordinate.between?(0, 7) }
  end
end
