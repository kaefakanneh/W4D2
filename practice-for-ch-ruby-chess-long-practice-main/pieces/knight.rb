require_relative 'piece'
class Knight < Piece
  def symbol
    '♞'
  end

  protected

  def move_diffs
    # [1, 2, -1, -2].permutation(2).to_a.reject { |i, j| i.abs == j.abs }
    [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
  end
end
