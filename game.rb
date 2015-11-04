require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'display.rb'

class Game

  def initialize(name1, name2)
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(@board, name1, :white)
    @player2 = Player.new(@board, name2, :black)
  end

  def play
    @current_player = @player1

    until @board.checkmate?(:black) || @board.checkmate?(:white)
      @display.render

      if @board.in_check?(@current_player.color)
        puts "#{@current_player.color} is in check!"
      end

      begin
        start_pos = @current_player.take_turn
        end_pos = @current_player.take_turn
        @board.move(start_pos, end_pos)
      rescue PieceError => e
        puts "No piece at selected position!"
        retry
      rescue CheckError => e
        puts "That would put you in check!"
        retry
      end


      switch_players!
    end
    @display.render
    self.switch_players!
    puts "#{@current_player.name} has won!"
  end

  def switch_players!
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

end





# if __FILE__ == $PROGAM_NAME
  game = Game.new("Player1", "Player2")
  game.play
# end
