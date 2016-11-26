require_relative 'display'
require_relative 'player'

class ChessGame

  attr_reader :board, :display, :player1, :player2

  def initialize(name1, name2)
    @board = Board.new
    @player1 = HumanPlayer.new(name1, :white, self)
    @player2 = HumanPlayer.new(name2, :black, self)
    @current_player = @player1
    @display = Display.new(board)
  end

  def play
    while true
      begin
      from_pos, to_pos = @current_player.get_move
      @board.move_piece(from_pos, to_pos, @current_player)

      rescue => error
      puts error
      sleep(1.5)
      @board.selected = nil
      retry
      end

      switch_players!
    end

    [:white, :black].each do |color|
      if @board.checkmate(color)
        puts "Checkmate! #{color} has lost"
        return :color
      end
    end
  end

end

def switch_players!
  @current_player = (@current_player == @player1 ? @player2 : @player1)
end
