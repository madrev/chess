class NullPiece < Piece
  include Singleton

  private

  def initialize
    @color = nil

  end
end
