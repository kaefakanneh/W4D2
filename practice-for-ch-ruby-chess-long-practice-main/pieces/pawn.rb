# require_relative 'piece'
class Pawn < Piece
  def symbol
    '♟'
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    return pos[0] == 1 if color == :white
    return pos[0] == 6 if color == :black

    raise 'Pawns should be either black or white'
  end

  def forward_dir
    return 1 if color == :white
    return -1 if color == :black

    raise 'Pawns should be either black or white'
  end

  def forward_steps
    steps = []
    potentially_valid_pos = [pos.first + forward_dir, pos.last]
    return steps unless board.valid_pos?(potentially_valid_pos)
    return steps unless board[potentially_valid_pos].color == :empty

    # potentially_valid_pos is valid! add it to the forward steps
    steps << potentially_valid_pos

    if at_start_row?
      potentially_valid_pos = [potentially_valid_pos.first + forward_dir, potentially_valid_pos.last]
      return steps unless board.valid_pos?(potentially_valid_pos)

      steps << potentially_valid_pos if board[potentially_valid_pos].color == :empty
    end

    steps
  end

  def side_attacks
    moves = []
    dirs = [[forward_dir, 1], [forward_dir, -1]]
    dirs.each do |dir|
      potentially_valid_pos = pos.zip(dir).map(&:sum)
      next unless board.valid_pos?(potentially_valid_pos)

      moves << potentially_valid_pos if board[potentially_valid_pos] == opponent_color
    end
    moves
  end
end
