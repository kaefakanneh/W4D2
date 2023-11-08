require_relative 'piece'
class King < Piece
  def symbol
    '♚'
  end

  protected

  def move_diffs
    # ([0,1,-1]*2).permutation(2).to_a.uniq.reject{|diff|diff==[0,0]}
    [[0, 1], [0, -1], [1, 0], [1, -1], [1, 1], [-1, 0], [-1, 1], [-1, -1]]
  end
end
