require_relative 'board'
require_relative 'display'
require 'byebug'

class Game

  attr_accessor :board, :current_player, :display

  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @board = board
    @display = Display.new(board)
  end

  def play
    while true
      @display.show_board
      # debugger
      if @display.cursor.selected
        #white
        if @current_player == @player1 && board[display.cursor.cursor_pos].color == "White"
          start_pos = display.cursor.cursor_pos
        elsif @current_player == @player1
          display.cursor.selected = false
        #black
        elsif @current_player == @player2 && board[display.cursor.cursor_pos].color == "Black"
          start_pos = display.cursor.cursor_pos
        else
          display.cursor.selected = false
        end

      else
        #make move
        end_pos = display.cursor.cursor_pos
        begin
          board.move_piece(start_pos, end_pos)
        rescue RuntimeError => e
          puts e
          next
        end
        switch_players

        #checkmate?
        break if board.checkmate?("White")
        break if board.checkmate?("Black")

      end

    end
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
end


if __FILE__==$PROGRAM_NAME
  game = Game.new("Ian", "Brandon")
  game.play
end
