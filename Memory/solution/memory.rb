require_relative "board"
require_relative "player"
require 'byebug'
class MemoryGame
  attr_reader :player

  def initialize(player, size = 4)
    @board = Board.new(size)
    @previous_guess = nil
    @player = player
  end

  def compare_guess(new_guess)
    unless previous_guess
      self.previous_guess = new_guess
      player.previous_guess = new_guess
      return
    end

    begin
      unless match?(previous_guess, new_guess)
        puts "Try Again"
        [previous_guess, new_guess].each { |pos| board.hide(pos) }
        raise ArgumentError.new
      end
      player.receive_match(previous_guess, new_guess)
    ensure
      self.previous_guess = nil
      player.previous_guess = nil
    end
  end

  def get_player_input
    pos = nil

    begin
      pos = player.get_input
      unless pos && valid_pos?(pos)
        raise ArgumentError.new
      end
    rescue ArgumentError
      puts "That is not on the board!"
      retry
    end

    pos
  end

  def make_guess(pos)
    revealed_value = board.reveal(pos)
    player.receive_revealed_card(pos, revealed_value)
    board.render

    compare_guess(pos)

    sleep(1)
    board.render
  end

  def match?(pos1, pos2)
    board[pos1] == board[pos2]
  end

  def play
    board.render
    begin
      pos = get_player_input
      make_guess(pos)
      unless board.won?
        raise ArgumentError.new "Keep Going"
      end
    rescue ArgumentError => e
      puts "#{e}"
      retry
    end

    puts "Congratulations, you win!"
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.count == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  private
  attr_accessor :previous_guess
  attr_reader :board
end

if __FILE__ == $PROGRAM_NAME
  size = ARGV.empty? ? 4 : ARGV.shift.to_i
  MemoryGame.new(HumanPlayer.new(size), size).play
end
