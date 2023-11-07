require_relative 'piece'

class Board
  def initialize
    @rows = Array.new(8) do |row_index|
      Array.new(8) do |column_index|
        case row_index
        when 0, 1
          Piece.new(:white, self, [row_index, column_index])
        when 6, 7
          Piece.new(:black, self, [row_index, column_index])
        else
          nil
        end
      end
    end
  end

  # def move_piece(start_pos, end_pos)
  #   raise "" if there is no piece at start_pos
  # end
end
