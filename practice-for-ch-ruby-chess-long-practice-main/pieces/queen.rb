# require_relative 'piece.rb'
# require_relative 'slidable.rb'

class Queen < Piece
  include Slidable

  def symbol
    "♛"
  end

  def move_dirs
    straight_dirs + diagonal_dirs
  end

end
