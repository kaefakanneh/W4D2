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

  def moves
    # straight moves = ...[[d,4 d5, d4, d3, nil], [nil], [], []]
    # diag moves = ...
    # loop until all directions blocked
    # grow_unblocked_moves_in_dir

    straight_moves = [[], [], [], []]
    diagonal_moves = [[], [], [], []]

    # block certain directions at the start if the current piece cant move in that way
    straight_moves = [[nil], [nil], [nil], [nil]] unless move_dirs.include?(:straight)
    diagonal_moves = [[nil], [nil], [nil], [nil]] unless move_dirs.include?(:diagonal)

    [straight_moves, diagonal_moves].each do |grown_moves|

      # until all moves blocked
      # a direction is blocked if it's moves ends in nil
      until grown_moves.map(&:last).all?(&:nil?)
        grow_unblocked_moves_in_dir(grown_moves)
      end
    end
  end

  private

  # ✅ line 47 if moves[current direction] ends with nil, it's blocked. skip to the next direction!
  # ✅ line 48 if moves[current direction] is empty? that means  we're the first iteration and we start at self.pos
  #
  # ✅ line 53 if moves[current direction] is not empty?, that means w're not the first, and we start at the omst recent
  # valid position in that diraction
  #
  def grow_unblocked_moves_in_dir(grown_moves)

    4.times do |direction_index|
      next if grown_moves[direction_index].last.nil?

      if grown_moves[direction_index].empty?
        grow_from_pos = self.pos
      else
        grow_from_pos = grown_moves[direction_index].last
      end

      grow_unblocked_moves_from_pos(grow_from_pos, direction_index, grown_moves)
    end
  end

  def grow_unblocked_moves_from_pos(grow_from_pos, direction_index, grown_moves)
    # find the next position in this direction, using the constant STRAIGHT_DIRS or DIAGONAL_DIRS
    # check whats on the at that position:
    # if it's empty, just add that valid pos as a valid move
    # if its a friendly pieces, add nil to show that it's blocked
    # if its an opponent pieces,  add that valid pos as a valid move, but also add nil to show that it's blocked

    # add the position we're growing from with the constant direction offset to find the position of the adjecent space
    # in the direction we're currently working with
    potentially_valid_pos = grow_from_pos.zip(STRAIGHT_DIRS[direction_index]).map(&:sum)
    target_piece_color =  board[potentially_valid_pos].color

    if target_piece_color == :empty # must be null piece, meaning a empty space
      # potentially valid move is valid!! :D
      grown_moves[direction_index] << potentially_valid_pos
    elsif target_piece_color == self.color # frinedly piece
      # potentially valid move is invalid!! D:
      grown_moves[direction_index] << nil
    else # opponent piece
      # potentially valid move is valid!! :D
      grown_moves[direction_index] << potentially_valid_pos
      # but all further moves are blocked
      grown_moves[direction_index] << nil
    end
  end
end
