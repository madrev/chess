require_relative 'board'
require_relative 'cursor'
require_relative 'piece'
require_relative 'piece_modules'
require 'colorize'

class Display
  attr_reader :cursor

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def display_space(pos)
    if @board[pos].nil?
      disp = "   "
    else
      disp = " #{@board[pos].symbol} "
    end

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
