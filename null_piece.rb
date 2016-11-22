require 'singleton'

class NullPiece < Piece
  include Singleton

  private

  def initialize
    @color = nil
    @symbol = " "
  end
end
