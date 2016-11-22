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

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], @board)
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
    while true
      self.render
      break if @cursor.get_input
    end
  end


end
