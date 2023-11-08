require_relative 'board'

module Slidable
  STRAIGHT_DIRS = [
    # Up
    [1, 0],
    # Down
    [-1, 0],
    # Right
    [0, 1],
    # Left
    [0, -1]
  ].freeze
  DIAGONAL_DIRS = [
    # Up-right
    [1, 1],
    # Down-right
    [-1, 1],
    # Up-left
    [1, -1],
    # Down-left
    [-1, -1]
  ].freeze

  def straight_dirs
    STRAIGHT_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []

    move_dirs.each do |dir|
      moves << grow_unblocked_moves_in_dir(dir)
    end
    moves
  end

  private

  def grow_unblocked_moves_in_dir(dir)
    moves = []
    potentially_valid_pos = pos
    loop do
      potentially_valid_pos = potentially_valid_pos.zip(dir).map(&:sum)
      break unless board.valid_pos?(potentially_valid_pos)

      target_piece_color =  board[potentially_valid_pos].color

      if target_piece_color == :empty # must be null piece, meaning a empty space
        # potentially valid move is valid!! :D
        moves << potentially_valid_pos
      elsif target_piece_color == color # frinedly piece
        # potentially valid move is invalid!! D:
        break
      else # opponent piece
        # potentially valid move is valid!! :D
        moves << potentially_valid_pos
        # but all further moves are blocked
        break
      end
    end
    moves
  end
end
