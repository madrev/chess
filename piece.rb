class Piece
  attr_reader :color, :symbol, :board
  attr_accessor :pos, :board

  def initialize(color, board, pos = nil)
    @color = color
    @board = board
    @pos = pos
  end

  def add_diff(start_pos, diff)
    [start_pos, diff].transpose.map { |x| x.inject(:+) }
  end

  def opposite_color?(piece2)
    @color == :white ? piece2.color == :black : piece2.color == :white
  end

  def move_into_check?(end_pos)
    test_board = @board.dup
    test_board.move_piece!(@pos, end_pos)
    test_board.in_check?(@color)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

end
