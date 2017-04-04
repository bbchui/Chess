require_relative 'board'
require_relative 'Slidable'
require_relative 'Steppable'

class Piece
  attr_accessor :pos
  attr_reader :symbol, :board, :color

  def initialize(board, color, pos)
    @symbol = :X
    @pos = pos
    @board = board
    @color = color
  end


  def valid_moves(pos_movs)
    pos_movs.reject! do |move|
      move_into_check(move)
    end
  end

  def to_s
    "#{symbol.to_s}"
  end

  def empty?
    false
  end

  private

  def move_into_check(to_pos)
    board_dup = board.deep_dup
    board_dup.move_piece(pos, to_pos)
    return true if board_dup.in_check?(color)
    false
  end


end

class Queen < Piece
  include Slidable

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = :Q
  end
end

class King < Piece
  include Steppable

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = :X
  end
end

class Knight < Piece
  include Steppable

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = :K
  end
end

class Rook < Piece
  include Slidable

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = :R
  end
end

class Bishop < Piece
  include Slidable

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = :B
  end
end

require 'byebug'
class Pawn < Piece

  def initialize(board, color, pos)
    super(board, color, pos)
    @symbol = :P
  end


  def moves
    valid_moves(forward_steps + side_attacks)
  end


  private

  def at_start_row?
    pos[0] == 1 || pos[0] == 6
  end

  def forward_dir
    if color == "White"
      return "Up"
    else
      return "Down"
    end
  end

  def forward_steps
    if color == "White"
      moves = [[pos[0] + 1, pos[1]]]
      if at_start_row?
        moves << [pos[0] + 2, pos[1]]
      end
    else
      moves = [[pos[0] - 1, pos[1]]]
      if at_start_row?
        moves << [pos[0] - 2, pos[1]]
      end
    end
    moves.reject! do |move|
      !board[move].is_a?(NullPiece)
    end
    moves
  end

  def side_attacks
    if color == "White"
      moves = [[(pos[0] + 1), (pos[1]+1)], [(pos[0]-1), (pos[1]+1)]]
      moves.reject! do |move|
        board[move].is_a?(NullPiece) || board[move].color == color
      end
    else
      moves = [[(pos[0] + 1), (pos[1]-1)], [(pos[0]-1), (pos[1]-1)]]
      moves.reject! do |move|
        board[move].is_a?(NullPiece) || board[move].color == color
      end
    end
    moves
  end
end

require 'singleton'

class NullPiece < Piece
  include Singleton

  attr_reader :color

  def initialize
    @symbol = :_
  end

  def empty?
    true
  end

  def moves
    []
  end


end
