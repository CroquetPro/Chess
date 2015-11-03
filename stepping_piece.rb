class SteppingPiece < Piece

end

class Knight < SteppingPiece
  def initialize
    @symbol = :N
    super(board, color, pos)
  end

end

class King < SteppingPiece
  def initialize
    @symbol = :K
    super(board, color, pos)
  end

end
