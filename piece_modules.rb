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
    result = []
    move_diffs.each do |diff|
      new_pos = add_diff(start_pos, diff)
      at_pos = board[new_pos]
      if @board.in_bounds?(new_pos) && at_pos.color != self.color
        result << new_pos
      end
    end
    result
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

  def move_diffs
    [[-2, 1], [-2, -1], [2, 1], [2, -1], [1, -2], [1, 2], [-1, -2], [-1, 2]]
  end


end

class King < Piece
  include SteppingPiece

  def initialize(color, board)
    super
    @symbol = "K"
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end

end

class Pawn < Piece
  # TODO: toggle @moved when pawn is moved in play logic

  def initialize(color, board)
    super
    @symbol = "P"
    @moved = false
  end

  def forward_diffs
    result = []
    one_foward = (self.color == :white ? [-1, 0] : [1, 0])
    result << one_foward
    result << [one_foward[0]*2, 0]
  end

  def capture_diffs
    self.color == :white ? [[-1,1], [-1,-1]] : [[1,1], [1,-1]]
  end

  def moves(start_pos)
    #TODO: DRY this out
    result = []
    capture_diffs.each do |diff|
      result << diff if board[add_diff(start_pos, diff)].class != NullPiece
    end
    forward_diffs.each do |diff|
      result << diff if board[add_diff(start_pos, diff)].class == NullPiece
    end

  end


end
