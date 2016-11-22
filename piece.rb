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

end
