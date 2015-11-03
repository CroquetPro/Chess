require 'colorize'

class Piece
  attr_reader :symbol, :color, :pos

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

  def friend?(poss_move)
    return true if @board[poss_move].color == self.color
    return false
  end

  def enemy?(poss_move)
    enemy = self.color == :white ? :black : :white
    return true if @board[poss_move].color == enemy
    return false
  end

  # def moves
  #
  # end

  def to_s
    # if self.color == :white
    " #{self.symbol} "
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
