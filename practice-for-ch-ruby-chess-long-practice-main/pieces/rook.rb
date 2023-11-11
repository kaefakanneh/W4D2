# require_relative 'piece.rb'
# require_relative 'slidable.rb'

class Rook < Piece
  include Slidable

  def move_dirs
    straight_dirs
  end
end
