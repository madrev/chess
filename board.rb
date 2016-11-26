require_relative 'piece'
require_relative 'piece_modules'
require_relative 'player'

class Board

  attr_reader :grid
  attr_accessor :selected

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_grid
    update_positions
    @selected = nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def move_piece(start_pos, end_pos, player)
    if self[start_pos].move_into_check?(end_pos)
      raise "That move leaves you in check!"
    elsif self[start_pos].color != player.color
      raise "That's not your piece! Try again."
    elsif self[start_pos].valid_moves.include?(end_pos)
      move_piece!(start_pos, end_pos)
      @selected = nil
    else
      raise "Invalid move, sorry"
    end
  end

  def move_piece!(start_pos, end_pos)
    #TODO: figure out whether these exceptions are needed
    unless in_bounds?(start_pos) && in_bounds?(end_pos)
      raise "Out of bounds!"
    end
    piece = self[start_pos]
    raise "No piece there!" if piece.nil?

    self[end_pos] = piece
    piece.pos = end_pos
    self[start_pos] = NullPiece.instance
  end

  def dup
    result = Board.new
    result.grid = Board.deep_dup(@grid)
    result.grid.flatten.each do |piece|
      piece.board = result
      piece.pos = piece.pos.dup
    end
    result
  end

  def in_bounds?(pos)
    pos.is_a?(Array) && pos.all? { |x| (0..7).cover?(x) }
  end

  def all_pieces
    @grid.flatten.select {|piece| piece.class != NullPiece}
  end

  def in_check?(color)
    king = @grid.flatten.find {|piece| piece.class == King && piece.color == color}
    all_pieces.any? do |piece|
      piece.opposite_color?(king) &&
      piece.moves.include?(king.pos)
    end
  end

  def checkmate?(color)
    in_check?(color) && all_pieces.none? {|piece|}
    all_pieces.none? {|piece| piece.color == color && piece.valid_moves.size > 0}
  end
  #private
  attr_writer :grid

  def self.deep_dup(obj)
    return obj if obj.is_a?(NullPiece)
    return obj.dup unless obj.is_a?(Array)
    obj.map {|el| deep_dup(el)}
  end

  def setup_row
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  end

  def populate_grid
    @grid[0] = setup_row.map { |type| type.new(:black, self) }
    @grid[1].fill { Pawn.new(:black, self) }
    @grid[2..5].each { |row| row.fill(NullPiece.instance) }
    @grid[6].fill { Pawn.new(:white, self) }
    @grid[7] = setup_row.map { |type| type.new(:white, self) }
  end

  def update_positions
    @grid.each.with_index do |row, i|
      row.each.with_index do |piece, j|
        piece.pos = [i, j]
      end
    end
  end


  end
