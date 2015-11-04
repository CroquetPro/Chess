class Pawn < Piece
  attr_reader :pos

  def initialize(board, color, pos)
    @symbol = :i
    super(board, color, pos)
  end

  def moves
    moves = []
    moves.concat(starting_moves)
    moves.concat(normal_moves)
    moves.concat(attack_moves)

    moves
  end

  def starting_moves #PRIVATE?
    moves = []

      if self.color == :black
        return [] unless @pos[0] == 1
        new_pos = [@pos[0] + 2, @pos[1]]
        jumped_pos = [@pos[0] + 1, @pos [1]]
        unless occupied?(new_pos) || occupied?(jumped_pos)
          moves << new_pos
        end
      elsif self.color == :white
        new_pos = [@pos[0] - 2, @pos[1]]
        jumped_pos = [@pos[0] - 1, @pos [1]]
        unless occupied?(new_pos) || occupied?(jumped_pos)
          moves << new_pos if @pos[0] == 6
        end
      end

    moves
  end

  def normal_moves #PRIVATE?
    moves = []

    if self.color == :black
      poss_move = [@pos[0] + 1, @pos[1]]
       if in_bounds?(poss_move) && !occupied?(poss_move)
         moves << poss_move
       end
     elsif self.color == :white
       poss_move = [@pos[0] - 1, @pos[1]]
        if in_bounds?(poss_move) && !occupied?(poss_move)
          moves << poss_move
        end
      end

      moves
  end

  def attack_moves #PRIVATE?
    moves = []

    self.move_diff.each do |dir|
      poss_move = [@pos[0] + dir[0], @pos[1] + dir[1]]
      moves << poss_move if in_bounds?(poss_move) && enemy?(poss_move)
    end

    moves
  end

  def occupied?(poss_move) #PRIVATE?
    return true if friend?(poss_move) || enemy?(poss_move)
    return false
  end

  def move_diff
    if self.color == :black
      [[1, 1], [1, -1]]
    else
      [[-1, -1], [-1, 1]]
    end
  end

end
