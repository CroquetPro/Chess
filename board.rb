require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'
require_relative 'piece.rb'
require_relative 'display.rb'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    self.populate
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

  def valid_pos?(start_pos, end_pos)
    return false unless in_bounds?(start_pos) && in_bounds?(end_pos)

    #piece.moves

  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end
end

b = Board.new
d = Display.new(b)
# r = King.new(b, :white, [5, 4])
# puts r.symbol
# p r.moves

# result = nil
# until result
d.render
#   result = d.get_input
# end
# result
