require_relative 'piece'


class Board

  def initialize
    @grid = Board.new_grid
  end

  def self.new_grid
    i = 0
    grid = Array.new(8) do |idx|
      if i.between?(2,5)
        Array.new(8) { nil }
      else
        Array.new(8) {Piece.new}
      end
      i += 1
    end

    grid
  end


end
