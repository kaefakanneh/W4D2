require_relative 'piece'
class NullPiece < Piece
  def initialize(board, pos)
    super(:empty, board, pos)
  end

  def moves
    []
  end

  def symbol
    '_'
  end
end
