require_relative 'piece.rb'

class SlidingPiece < Piece


  def moves
    moves = []
    self.move_dir.each do |dir|
      row = @pos[0]
      col = @pos[1]

      8.times do
        row += dir[0]
        col += dir[1]
        poss_move = [row, col]
        # return moves if occupied?(poss_move)
        #break early if already out bounds?
        moves << poss_move if in_bounds?(poss_move)
        # return moves if enemy?(poss_move)
      end

    end

    moves
  end



end

class Bishop < SlidingPiece
  attr_reader :symbol

  def initialize(board, color, pos)
    @symbol = :B
    super(board, color, pos)
  end

  def move_dir
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

end

class Rook < SlidingPiece
  attr_reader :symbol

  def initialize(board, color, pos)
    @symbol = :R
    super(board, color, pos)
  end

  def move_dir
    [[0, -1], [0, 1], [-1, 0], [1, 0]]
  end

end

class Queen < SlidingPiece
  attr_reader :symbol
  
  def initialize(board, color, pos)
    @symbol = :Q
    super(board, color, pos)
  end

  def move_dir
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, -1], [0, 1], [-1, 0], [1, 0]]
  end
end
