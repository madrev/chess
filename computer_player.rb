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
    possible_movers = my_pieces.reject {|piece| piece.valid_moves.empty?}

    if !possible_captures(possible_movers).empty?
      return possible_captures(possible_movers).sample
    else
      move_from = possible_movers.sample.pos
      move_to = @game.board[move_from].valid_moves.sample
      return [move_from, move_to]
    end
  end

  private
  def possible_captures(pieces)
    #TODO: debug argument error
    result = []
    pieces.each do |piece|
      piece.valid_moves.each do |end_pos|
        result << [piece.pos, end_pos] if @game.board[end_pos].class != NullPiece
      end
    end
    result
  end



end
