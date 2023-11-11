


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

  def self.symbol_to_piece(symbol, color, board, pos)
    case symbol
    when :♜
      Rook.new(color, board, pos)
    when :♞
      Knight.new(color, board, pos)
    when :♝
      Bishop.new(color, board, pos)
    when :♛
      Queen.new(color, board, pos)
    when :♚
      King.new(color, board, pos)
    when :♟
      Pawn.new(color, board, pos)
    else
      NullPiece.instance
    end
  end
end

# require_relative 'pawn'
# require_relative 'knight'
# require_relative 'king'
# require_relative 'rook'
# require_relative 'queen'
# require_relative 'bishop'
