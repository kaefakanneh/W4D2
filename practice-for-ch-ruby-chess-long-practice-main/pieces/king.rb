# require_relative 'piece'
# require_relative 'stepable'
class King < Piece
  include Stepable
  def symbol
    '♚'
  end

  protected

  def move_diffs
    # ([0,1,-1]*2).permutation(2).to_a.uniq.reject{|diff|diff==[0,0]}
    [[0, 1], [0, -1], [1, 0], [1, -1], [1, 1], [-1, 0], [-1, 1], [-1, -1]]
  end
end
