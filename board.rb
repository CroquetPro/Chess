require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'
require_relative 'piece.rb'
require_relative 'display.rb'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(real_board = true)
    real_board = real_board
    @grid = Array.new(8) {Array.new(8)}
    self.populate if real_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def populate
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |val, col_idx|
        if row_idx < 2
          color = :black
          if row_idx == 0 && (col_idx == 0 || col_idx == 7)
            @grid[row_idx][col_idx] = Rook.new(self, color, [row_idx, col_idx])
        #   @grid[row_idx][col_idx] = Piece.new(self, :black, [row_idx, col_idx]) ##board, color, pos,
          elsif row_idx == 0 && (col_idx == 1 || col_idx == 6)
            @grid[row_idx][col_idx] = Knight.new(self, color, [row_idx, col_idx])
          elsif row_idx == 0 && (col_idx == 2 || col_idx == 5)
            @grid[row_idx][col_idx] = Bishop.new(self, color, [row_idx, col_idx])
          elsif row_idx == 0 && col_idx == 3
            @grid[row_idx][col_idx] = Queen.new(self, color, [row_idx, col_idx])
          elsif row_idx == 0 && col_idx == 4
            @grid[row_idx][col_idx] = King.new(self, color, [row_idx, col_idx])
          elsif row_idx == 1
              @grid[row_idx][col_idx] = Pawn.new(self, color, [row_idx, col_idx])
          end
        elsif row_idx > 5
          color = :white
          if row_idx == 7 && (col_idx == 0 || col_idx == 7)
            @grid[row_idx][col_idx] = Rook.new(self, color, [row_idx, col_idx])
        #   @grid[row_idx][col_idx] = Piece.new(self, :black, [row_idx, col_idx]) ##board, color, pos,
          elsif row_idx == 7 && (col_idx == 1 || col_idx == 6)
            @grid[row_idx][col_idx] = Knight.new(self, color, [row_idx, col_idx])
          elsif row_idx == 7 && (col_idx == 2 || col_idx == 5)
            @grid[row_idx][col_idx] = Bishop.new(self, color, [row_idx, col_idx])
          elsif row_idx == 7 && col_idx == 3
            @grid[row_idx][col_idx] = Queen.new(self, color, [row_idx, col_idx])
          elsif row_idx == 7 && col_idx == 4
            @grid[row_idx][col_idx] = King.new(self, color, [row_idx, col_idx])
          elsif row_idx == 6
            @grid[row_idx][col_idx] = Pawn.new(self, color, [row_idx, col_idx])
          end
        #   @grid[row_idx][col_idx] = Piece.new(self, :white, [row_idx, col_idx])
        else
          @grid[row_idx][col_idx] = NullPiece.new
        end
      end
    end
  end

  def move(start_pos, end_pos)
    raise "No piece at #{start_pos}." if self[start_pos].nil?
    raise "Invalid move" if valid_pos?(start_pos, end_pos)

    self[start_pos], self[end_pos] = nil, self[start_pos]

  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_color = ((color == :white) ? :black : :white)
    all_moves(enemy_color).include?(king_pos)
  end

  def checkmate?(color)
    # debugger
    valid_moves = []

    @grid.each do |row|
      row.each do |piece|
        next if piece.color != color
        valid_moves << piece.valid_moves
      end
    end

    return true if in_check?(color) && valid_moves.empty?
    return false
  end

  def all_moves(color) # PRIVATE?
    all_moves = []

    @grid.each do |row|
      row.each do |piece|
        if piece.color == color
          all_moves.concat(piece.moves)
        end
      end
    end

    all_moves
  end

  def find_king(color) #PRIVATE?
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |val, col_idx|
        if val.color == color && val.symbol == :K
          return [row_idx, col_idx]
        end
      end
    end
  end

  def dup
    duped_board = Board.new(false)
    self.grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        color, pos = piece.color, [row_idx, col_idx]
        duped_board[pos] = piece.class.new(duped_board, color, pos)
      end
    end

    duped_board
  end

  def move!(start_pos, end_pos)
    # debugger
    start = self[start_pos]
    target = self[end_pos]

    if target.is_a?(NullPiece)
      start, target = target, start
    elsif target.enemy?(end_pos)
      start, target = NullPiece.new, start
    end
  end

  # def valid_move?(start_pos, end_pos)
  #   return false unless in_bounds?(start_pos) && in_bounds?(end_pos)
  #
  #   #piece.moves
  #
  # end

  def in_bounds?(pos) #PRIVATE?
    pos.all? { |x| x.between?(0, 7) }
  end
end

b = Board.new
c = b.dup
c[[2,4]] = King.new(c, :white, [2, 4])
e = Display.new(c)
e.render
p c.checkmate?(:white)
# result = nil
# until result
# d.render
#   result = d.get_input
# end
# result
