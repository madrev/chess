class HumanPlayer
  attr_reader :color, :name

  def initialize(name, color = :white, game)
    @name = name
    @color = color
    @game = game
  end

  def get_move
    #TODO: refactor this into two separate methods, get_selection and get_move. Maybe?
    system("clear")
    move_to = @game.display.go(@name, display_color)
    [@game.board.selected, move_to]
  end

  def display_color
    @color == :white ? "green" : "blue"
  end


end
