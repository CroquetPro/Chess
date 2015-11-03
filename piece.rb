class Piece
  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
  end

  def present?
    true
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def move


  end

  def to_s
    " x "
  end
end

class NullPiece < Piece
  def initialize
  end

  def present?
    false
  end

  def to_s
    "   "
  end
end
