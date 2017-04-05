require 'colorize'
require_relative 'board'
require_relative 'cursor'
require 'byebug'
class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def show_board
    while true
      render
      input = cursor.get_input
      system("clear")
      if input == :space || input == :return
        break
      end
    end
  end

  def render
    i = 1
    board.grid.each_with_index do |row, idx|
      n_row = []
      row.each_with_index do |el, jdx|
        if i.even?
          n_row << " #{el.to_s.colorize(el.color.downcase.to_sym)} ".colorize(:background => :light_black)
        else
          n_row << " #{el.to_s.colorize(el.color.downcase.to_sym)} ".colorize(:background => :light_red)
        end
        i += 1
        if [idx, jdx] == cursor.cursor_pos
          if cursor.selected
            n_row[jdx] = n_row[jdx].colorize(:background => :green)
          else
            n_row[jdx] = n_row[jdx].colorize(:background => :default)
          end
        end
      end
      puts n_row.join()
      i += 1
    end
    if cursor.selected
      puts "#{board[cursor.cursor_pos].class}"
    end
  end

end


if __FILE__==$PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.show_board
end
