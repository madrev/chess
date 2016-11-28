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
      play_turn
      switch_players!
      if !winner.nil?
        puts "Checkmate! #{winner.name} has won."
        return true
      end
    end

  end

  private

  def winner
    [@player1, @player2].each do |player|
      if @board.checkmate?(player.color)
        return (player == @player1 ? @player2 : @player1)
      end
    end
    nil
  end

  def play_turn
    begin
    from_pos, to_pos = @current_player.get_move
    @board.move_piece(from_pos, to_pos, @current_player)

    rescue => error
    puts error
    sleep(1.5)
    @board.selected = nil
    retry
    end

  end

  def switch_players!
    @current_player = (@current_player == @player1 ? @player2 : @player1)
    @board.selected = nil
  end

end



if __FILE__ == $PROGRAM_NAME
  puts "What's the name of the first player?"
  name1 = gets.chomp
  puts "What's the name of the second player?"
  name2 = gets.chomp

  game = ChessGame.new(name1,name2)
  game.play
end
