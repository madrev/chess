require_relative 'piece'
require_relative 'board'
require_relative 'null_piece'
require 'byebug'


module SlidingPiece
  #TODO: black sliding pieces aren't working. whyyyyy

  def moves(start_pos = @pos)
    result = []
    move_diffs.each do |diff|
      new_pos = add_diff(start_pos, diff)
      while @board.in_bounds?(new_pos)
        at_pos = board[new_pos]
        if at_pos.opposite_color?(self) || at_pos.class == NullPiece
          result << new_pos
        end
        break unless at_pos.class == NullPiece
        new_pos = add_diff(new_pos, diff)
      end
    end
    result
  end

end

module SteppingPiece

  def moves(start_pos = @pos)
    #byebug
    result = []
    move_diffs.each do |diff|
      new_pos = add_diff(start_pos, diff)
      if @board.in_bounds?(new_pos)
        at_pos = @board[new_pos]
        result << new_pos if at_pos.opposite_color?(self) || at_pos.class == NullPiece
      end
    end
    result
  end

end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, board, pos = nil)
    super
    @symbol = "B"
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(color, board, pos = nil)
    super
    @symbol = "R"
  end

  def move_diffs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(color, board, pos = nil)
    super
    @symbol = "Q"
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end


end

class Knight < Piece
  include SteppingPiece

  def initialize(color, board, pos = nil)
    super
    @symbol = "N"
  end

  def move_diffs
    [[-2, 1], [-2, -1], [2, 1], [2, -1], [1, -2], [1, 2], [-1, -2], [-1, 2]]
  end


end

class King < Piece
  include SteppingPiece

  def initialize(color, board, pos = nil)
    super
    @symbol = "K"
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end

end

class Pawn < Piece
  # TODO: toggle @moved when pawn is moved in play logic

  def initialize(color, board, pos = nil)
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

  def moves(start_pos = @pos)
    #TODO: DRY this out
    result = []
    capture_diffs.each do |diff|
      new_pos = add_diff(start_pos, diff)
      next unless board.in_bounds?(new_pos)
      if board[new_pos].class != NullPiece && board[new_pos].opposite_color?(self)
        result << new_pos
      end
    end

    forward_diffs.each do |diff|
      new_pos = add_diff(start_pos, diff)
      #combine this next & break into one break?
      next unless board.in_bounds?(new_pos)
      break unless board[new_pos].class == NullPiece
      result << new_pos
    end
    result.select {|pos| board.in_bounds?(pos)}

  end


end
