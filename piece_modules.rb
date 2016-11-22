require_relative 'piece'
require_relative 'board'

# TODO: move super keywords to AFTER symbol initalization on all subclasses

module SlidingPiece

  def moves(start_pos)
    #TODO: debug this for Rook
    result = []
    move_diffs.each do |diff|
      current_pos = start_pos
      new_pos = add_diff(current_pos, diff)
      if board[new_pos].nil?
        result << new_pos
        current_pos = new_pos
      elsif board[new_pos].color != self.color
        result << new_pos
        next
      else
        next
      end
    end
    result
  end


  def add_diff(start_pos, diff)
    [start_pos, diff].transpose.map { |x| x.inject(:+) }
  end


end

module SteppingPiece

  def moves(start_pos)
  end

end

class Bishop < Piece
  include SlidingPiece

  def initialize(color, board)
    @symbol = "B"
    super
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(color, board)
    @symbol = "R"
    super
  end

  def move_diffs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(color, board)
    @symbol = "Q"
    super
  end

  def move_diffs
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  end


end

class Knight < Piece
  include SteppingPiece

  def initialize(color, board)
    @symbol = "N"
    super
  end

end

class King < Piece
  include SteppingPiece

  def initialize(color, board)
    @symbol = "K"
    super
  end

end

class Pawn < Piece

  def initialize(color, board)
    @symbol = "P"
    super
  end

end
