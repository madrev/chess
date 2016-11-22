class Piece
  attr_reader :color, :symbol, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

end
