require_relative 'piece'
require 'byebug'

class Board

  attr_accessor :grid

  def initialize
    @grid = new_grid
  end

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
    unless self[start_pos].moves.include?([end_pos])
      debugger
      raise RuntimeError.new("That is not a valid move!")
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
  end
end
