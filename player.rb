require_relative 'display.rb'

class Player

  attr_reader :name, :color

  def initialize(board, name, color)
    @name = name
    @color = color
    @display = Display.new(board)
  end

  def take_turn
    result = nil
    until result
      @display.render
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
