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
    @debug = true
  end





  def render
    system("clear")
    @board.grid.each_index do |i|
      @board.grid[i].each_index do |j|
        display_space([i, j])
      end
      print "\n"
    end
    nil
  end

  def go
    while true
      self.render

      if @debug == true && !board.selected.nil?
        show_debug(board.selected)
      end

      input_return = @cursor.get_input
      break if input_return == :escape

      if input_return.nil?
        next
      else
        return input_return
      end

    end
  end


  def show_debug(pos)
    piece = board[pos]
    if piece.class != NullPiece
      print "\n"
      puts "This piece is a #{piece.color} #{piece.class}"
      puts "Valid moves are #{piece.valid_moves}"
      if board.in_check?(piece.color)
        puts "#{piece.color} is in check!"
      end
      puts "Pick a place to move to!"
    end
  end

  private
  def display_space(pos)
    #TODO: make different colored pieces different colors
    disp = " #{@board[pos].symbol} "

    if pos == board.selected
      print_selected_disp(disp)
    elsif @cursor.cursor_pos == pos
      print_cursor_disp(disp)
    else
      print_piece_disp(disp, board[pos].color)
    end
    nil
  end

  def print_selected_disp(disp)
    print disp.colorize(:color => :black, :background => :magenta)
  end

  def print_cursor_disp(disp)
    print disp.colorize(:color => :black, :background => :light_cyan)
  end

  def print_piece_disp(disp, color)
    if color == :black
      print disp.colorize(:color => :blue)
    elsif color == :white
      print disp.colorize(:color => :green)
    else print disp
    end
  end

end
