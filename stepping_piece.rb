require_relative 'piece.rb'

class SteppingPiece < Piece

  def moves
    moves = []
    self.move_diff.each do |dir|
      poss_move = [@pos[0] + dir[0], @pos[1] + dir[1]]
      moves << poss_move if in_bounds?(poss_move) && !friend?(poss_move)
      # return moves if friend?(poss_move)
      # return moves if enemy?(poss_move)
    end

    moves
  end

end

class Knight < SteppingPiece

  def initialize(board, color, pos)
    @symbol = :N
    super(board, color, pos)
  end

  def move_diff
    [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2],[-1, -2], [-2, -1]]
  end

end

class King < SteppingPiece
  def initialize(board, color, pos)
    @symbol = :K
    super(board, color, pos)
  end


  def move_diff
    [[1, 1], [1, -1], [-1, 1], [-1, -1],
      [0, -1], [0, 1], [-1, 0], [1, 0]]
  end
end
