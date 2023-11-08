require_relative 'piece'
require 'singleton'
class NullPiece < Piece
  include Singleton
  def initialize
    super(:empty, nil, nil)
  end

  def moves
    []
  end

  def symbol
    '_'
  end
end
