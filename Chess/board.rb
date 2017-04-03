require_relative 'piece'


class Board

  attr_accessor :grid

  def initialize
    @grid = Board.new_grid
  end

  def self.new_grid

    grid = Array.new(8) {Array.new}
    i = 0
    grid.each do |row|
      if i.between?(2,5)
        8.times {row << nil}
      else
        8.times {row << Piece.new}
      end
      i += 1
    end

    grid
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
    unless self[start_pos].is_a?(Piece)
      raise RuntimeError.new("There is no piece on the position.")
    end
    unless self[end_pos].nil?
      raise RuntimeError.new("There is a piece at the end position.")
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

end
