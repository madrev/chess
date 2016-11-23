class ChessGame

  def initialize(name1, name2)
    @player1 = HumanPlayer.new(name1)
    @player2 = HumanPlayer.new(name2)
    @board = Board.new
    @display = Display.new(board)
  end

end
