require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def show_board
    while true
      render
      cursor.get_input
      system("clear")
    end
  end

  def render
    board.grid.each_with_index do |row, idx|
      n_row = []
      row.each_with_index do |el, jdx|
        n_row << el.to_s
        if [idx, jdx] == cursor.cursor_pos
          if cursor.selected
            n_row[jdx] = n_row[jdx].colorize(:green)
          else
            n_row[jdx] = n_row[jdx].colorize(:red)
          end
        end
      end
      puts n_row.join(" ")
    end
  end

end


if __FILE__==$PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.show_board
end
