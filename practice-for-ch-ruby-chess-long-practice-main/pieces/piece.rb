class Piece
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?
    is_a?(NullPiece)
  end
end
