require_relative 'board'

class Piece
  attr_accessor :pos
  attr_reader :symbol, :board, :color

  def initialize(symbol, pos, board, color)
    @symbol = "X"
    @pos = pos
    @board = board
    @color = color
  end

  def moves
  end

  def to_s
    "#{self.class}"
  end

  def valid_moves
  end

  def empty?
    return true if type == :null_piece
    false
  end

  private

  def move_into_check(to_pos)
  end


end
