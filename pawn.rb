class Pawn < Piece
  def initialize
    @symbol = :p
    super(board, color, pos)
  end

end
