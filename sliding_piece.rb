require_relative 'piece.rb'

class SlidingPiece < Piece


  def moves
    moves = []
    self.move_dir.each do |dir|
      attack = false
      row = @pos[0]
      col = @pos[1]
      # debugger
      8.times do
        next if attack
          row += dir[0]
          col += dir[1]
          poss_move = [row, col]
          next if !in_bounds?(poss_move)
          if enemy?(poss_move)
            moves << poss_move
            attack = true
            next
          end
          next if friend?(poss_move)
          moves << poss_move
      end

    end

    moves
  end



end

class Bishop < SlidingPiece

  def initialize(board, color, pos)
    @symbol = :B
    super(board, color, pos)
  end

  def move_dir
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

end

class Rook < SlidingPiece

  def initialize(board, color, pos)
    @symbol = :R
    super(board, color, pos)
  end

  def move_dir
    [[0, -1], [0, 1], [-1, 0], [1, 0]]
  end

end

class Queen < SlidingPiece

  def initialize(board, color, pos)
    @symbol = :Q
    super(board, color, pos)
  end

  def move_dir
    [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, -1], [0, 1], [-1, 0], [1, 0]]
  end
end
