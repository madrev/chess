class Piece
  attr_reader :color, :symbol, :board
  attr_accessor :pos

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

end
