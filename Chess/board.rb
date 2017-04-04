require_relative 'piece'
require 'byebug'

class Board

  attr_accessor :grid

  def initialize(grid = new_grid)
    @grid = grid
  end

  def in_bounds(pos)
    pos.all? { |coord| coord.between?(0,7) }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @grid[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    unless self[start_pos].is_a?(Piece) && !self[start_pos].is_a?(NullPiece)
      raise RuntimeError.new("There is a piece at the end position.")
    end
    unless self[start_pos].moves.include?(end_pos)
      raise RuntimeError.new("That is not a valid move!")
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
  end

  def in_check?(color)
    king_pos = []
    @grid.each_with_index do |row, idx|
      row.each_with_index do |el, jdx|
        if el.is_a?(King) && el.color == color
          king_pos += [idx, jdx]
        end
      end
    end

    @grid.each do |row|
      row.each do |el|
        unless el.is_a?(NullPiece) || el.color == color
          pos_movs = el.moves
          return true if pos_movs.include?(king_pos)
        end
      end
    end
    false
  end

  def checkmate?(color)
    cant_move = @grid.flatten.all? do |el|
      if el.color == color
        el.valid_moves.length == 0
      end
    end
    cant_move && in_check?(color)
  end

  def deep_dup
    board_dup = Board.new([])

    @grid.each do |row|
      empty_row = []
      row.each do |el|
        if !el.is_a?(NullPiece)
          empty_row << el.class.new(board_dup, el.color, el.pos.dup)
        else
          empty_row << NullPiece.instance
        end
      end
      board_dup.grid << empty_row
    end

    board_dup
  end

  protected

  def new_grid

    grid = Array.new(8) {Array.new}
    grid.each_with_index do |row, idx|
      if idx == 0
        row << Rook.new(self, "White", [0, 0])
        row << Knight.new(self, "White", [0, 1])
        row << Bishop.new(self, "White", [0, 2])
        row << Queen.new(self, "White", [0, 3])
        row << King.new(self, "White", [0, 4])
        row << Bishop.new(self, "White", [0, 5])
        row << Knight.new(self, "White", [0, 6])
        row << Rook.new(self, "White", [0, 7])
      elsif idx == 1
        j = 0
        8.times do |el|
          row << Pawn.new(self, "White", [1, j])
          j+=1
        end
      elsif idx.between?(2,5)
        8.times {row << NullPiece.instance}
      elsif idx == 6
        j = 0
        8.times do |el|
          row << Pawn.new(self, "Black", [6, j])
          j+=1
        end
      else
        row << Rook.new(self, "Black", [7, 0])
        row << Knight.new(self, "Black", [7, 1])
        row << Bishop.new(self, "Black", [7, 2])
        row << Queen.new(self, "Black", [7, 3])
        row << King.new(self, "Black", [7, 4])
        row << Bishop.new(self, "Black", [7, 5])
        row << Knight.new(self, "Black", [7, 6])
        row << Rook.new(self, "Black", [7, 7])
      end
    end

    grid
  end

end
