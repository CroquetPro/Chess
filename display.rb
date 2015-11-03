require 'colorize'
# require_relative 'piece.rb'
require_relative 'cursor'
require_relative 'piece.rb'

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
      if piece.present?
        color = piece.color
      else
        color = :magenta
      end
      color_options = colors_for(i, j, color)
      piece.to_s.colorize(color_options) #piece color
    end
  end

  def colors_for(i, j, color)
    if [i, j] == @cursor_pos
      background = :light_green
    elsif (i + j).odd?
      background = :light_red
    else
      background = :light_blue
    end

    {background: background , color: color}

  end

  def render
    system("clear")
    letters = ("A".."H").to_a.join("  ")
    puts "   #{letters}  "
    build_grid.each_with_index do |row, i|
      puts "#{8 - i} #{row.join}"
    end
  end
end
