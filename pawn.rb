class Pawn < Piece
  def initialize(board, color, pos)
    @symbol = :i
    super(board, color, pos)
  end

  def moves
    moves = []

    if self.color == :black
      if @pos[0] == 1
        moves << [@pos[0] + 2, @pos[1]]
      else
        poss_move = [@pos[0] + 1, @pos[1]]
        moves << poss_move unless friend?(poss_move) || enemy?(poss_move)
      end
    end


    if self.color == :white
      if @pos[0] == 6
        move << [@pos[0] - 2, @pos[1]]
      else
        poss_move = [@pos[0] - 1, @pos[1]]
        moves << poss_move unless friend?(poss_move) || enemy?(poss_move)
      end
    end


    self.move_diff.each do |dir|
      poss_move = [@pos[0] + dir[0], @pos[1] + dir[1]]
      moves << poss_move if enemy?(poss_move)
    end

  end

  def move_diff
    if self.color == :black
      [[1, 1], [1, -1]]
    else
      [[-1, -1], [-1, 1]]
    end
  end

end
