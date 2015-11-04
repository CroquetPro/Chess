require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'display.rb'

class Game
  attr_reader :current_player

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

      begin
        moves = @current_player.get_move
        start_pos = moves[0]

        if @board[start_pos].color == @current_player.color
          @board.move(*moves)
        else
          raise PieceError.new
        end

      rescue PieceError => e
        p "Wrong piece!"
        retry
      rescue CheckError => e
        p "That would put you in check!"
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
