class Piece
  attr_reader :color, :symbol, :board

  def initialize(color, board)
    @color = color
    @board = board
    # TODO: remove this later, just for testing
    @symbol = "P"
  end

  def add_diff(start_pos, diff)
    [start_pos, diff].transpose.map { |x| x.inject(:+) }
  end

  def opposite_color?(piece2)
    @color == :white ? piece2.color == :black : piece2.color == :white
  end

end
