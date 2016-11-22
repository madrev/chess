require_relative 'piece'
require_relative 'piece_modules'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def move_piece(start_pos, end_pos)
    unless in_bounds?(start_pos) && in_bounds?(end_pos)
      raise "Out of bounds!"
    end

    piece = self[start_pos]
    raise "No piece there!" if piece.nil?

    destination_piece = self[end_pos]
    if destination_piece && destination_piece.color == piece.color
      raise "#{piece.color} piece there"
    end

    self[end_pos] = piece
    self[start_pos] = nil
  end


  #private

  def populate_grid
    @grid[0..1].each { |row| row.fill(Piece.new(:black, self)) }
    @grid[2..5].each { |row| row.fill(NullPiece.instance) }
    @grid[6..7].each { |row| row.fill(Piece.new(:white, self)) }
  end

  def in_bounds?(pos)
    pos.is_a?(Array) && pos.all? { |x| (0..7).cover?(x) }
  end


end
