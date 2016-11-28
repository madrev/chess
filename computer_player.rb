class ComputerPlayer
  attr_reader :color, :name

  def initialize(name = "Computerman", color = :white, game)
    @name = name
    @color = color
    @game = game
  end

  def get_move
    puts "#{@name} is moving..."
    sleep(1.5)
    my_pieces = @game.board.all_pieces(@color)
    move_from = my_pieces.reject {|piece| piece.valid_moves.empty?}.sample.pos
    move_to = @game.board[move_from].valid_moves.sample
    [move_from, move_to]
  end


end
