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
          @grid[row_idx][col_idx] = Piece.new(:black)
        elsif row_idx > 5
          @grid[row_idx][col_idx] = Piece.new(:white)
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
result = nil
until result
  d.render
  result = d.get_input
end
result
