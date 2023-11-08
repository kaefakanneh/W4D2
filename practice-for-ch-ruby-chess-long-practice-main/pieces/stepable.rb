module Stepable
  def moves
    move_diffs.map do |move_diff|
      pos.zip(move_diff).map(&:sum)
    end.select do |step_pos|
      board.valid_pos?(step_pos)
    end.reject do |step_pos|
      board[step_pos].color == color
    end
  end

  private

  def move_diffs
    raise NotImplementedError
  end
end
