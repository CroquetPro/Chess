require 'colorize'
# require_relative 'piece.rb'
require_relative 'cursor'

class Display
  include Cursor

  def initialize(board)
    @cursor_pos = [0, 0]
    @selected = false
    @board = board
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options) #piece color
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      background = :light_green
    elsif (i + j).odd?
      background = :light_black
    else
      background = :light_white
    end

    {background: background, color: :light_magenta}
  end

  def render
    system("clear")
    build_grid.each {|row| puts row.join}
  end
end
