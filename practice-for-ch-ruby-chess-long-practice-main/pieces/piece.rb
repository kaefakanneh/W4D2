class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?
    is_a?(NullPiece)
  end

  def opponent_color
    color == :white ? :black : :white
  end

  def to_s
    symbol
  end

  def symbol
    '?'
  end
end
