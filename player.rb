require_relative 'display.rb'

class Player

  attr_reader :name, :color

  def initialize(board, name, color)
    @board = board
    @name = name
    @color = color
    @display = Display.new(board)
  end

  def get_move
    start_pos = take_turn
    end_pos = take_turn
    @selected = false
    return [start_pos, end_pos]
  end

  def take_turn
    result = nil
    until result
      @display.render

      if @board.in_check?(self.color)
        puts "#{self.color.capitalize} is in check!"
      end

      puts "\n#{self.name}'s turn to play #{self.color}."
      result = @display.get_input

    end
    result
    # positions = []
  end
  #   result = []
  #   until result.length == 2
  #     @display.render
  #     result << @display.get_input
  #   end
  #   result #[[start_pos], [end_pos]]
  # end

end
