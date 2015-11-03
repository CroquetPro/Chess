require 'colorize'
require 'byebug'

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
    # debugger
    enemy = self.color == :white ? :black : :white
    return true if @board[poss_move].color == enemy
    return false
  end

  def valid_moves
    valid_moves = []
    start_board = @board
    moves.each do |poss_move|
      duped_board = @board.dup
      piece = duped_board[@pos]
      duped_board.move!(@pos, poss_move)
      valid_moves << poss_move unless duped_board.in_check?(piece.color)
    end

    valid_moves
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
  # attr_reader :color

  def initialize(*arg)
    # @color = :clear
  end

  def present?
    false
  end

  def to_s
    "   "
  end
end
