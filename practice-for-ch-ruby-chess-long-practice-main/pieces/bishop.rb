require_relative 'piece.rb'
require_relative 'slidable.rb'

class Bishop < Piece
  include Slidable

  def symbol
    "♝"
  end

  def move_dirs
    diagonal_dirs
  end
end