require_relative 'board'
require_relative 'cursor'
require_relative 'piece'
require_relative 'piece_modules'
require_relative 'null_piece'
require 'colorize'
require 'yaml'

class Display
  #added :board for pry
  attr_reader :cursor, :board
  attr_accessor :debug

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], @board)
    @debug = false
  end

  def display_space(pos)
    disp = " #{@board[pos].symbol} "

    if @cursor.cursor_pos == pos
      if @cursor.selected == true
        print disp.colorize(:color => :white, :background => :magenta)
      else
        print disp.colorize(:color => :white, :background => :light_blue)
      end
    else
      print disp
    end
    nil
  end

  def render
    system("clear")
    @board.grid.each_index do |i|
      @board.grid[i].each_index do |j|
        display_space([i,j])
      end
      print "\n"
    end
    nil
  end

  def go
    last_return = nil
    while true
      self.render
      if @debug == true && last_return
        show_debug(last_return)
        last_return = nil
      end
      input_return = @cursor.get_input
      break if input_return == :escape
      last_return = input_return

    end
  end

  def show_debug(pos)
    piece = board[pos]
    if piece.class != NullPiece
      print "\n"
      puts "This piece is a #{piece.color} #{piece.class}"
      puts "Valid moves are #{piece.valid_moves.to_s}"
      if board.in_check?(piece.color)
        puts "#{piece.color} is in check!"
      end
    end
  end


end
