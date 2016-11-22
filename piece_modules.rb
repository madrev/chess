require_relative 'piece'
require_relative 'board'
require_relative 'null_piece'


module SlidingPiece

  def moves(start_pos)
    result = []
    move_diffs.each do |diff|
      new_pos = add_diff(start_pos, diff)
      while @board.in_bounds?(new_pos)
        at_pos = board[new_pos]
        result << new_pos if at_pos.color != self.color
        break unless at_pos.class == NullPiece
        new_pos = add_diff(new_pos, diff)
      end
    end
    result
  end


end

module SteppingPiece

  def moves(start_pos)
  end

end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, board)
    super
    @symbol = "B"
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(color, board)
    super
    @symbol = "R"
  end

  def move_diffs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(color, board)
    super
    @symbol = "Q"
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end


end

class Knight < Piece
  include SteppingPiece

  def initialize(color, board)
    super
    @symbol = "N"
  end

end

class King < Piece
  include SteppingPiece

  def initialize(color, board)
    super
    @symbol = "K"
  end

end

class Pawn < Piece

  def initialize(color, board)
    super
    @symbol = "P"
  end

end
