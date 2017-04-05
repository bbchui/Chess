module Steppable

  def moves
    move_diffs
  end

  private

  def move_diffs
    all_moves = []

    if is_a?(King)
      -1.upto(1) do |idx|
        -1.upto(1) do |jdx|
          pos_mov = [pos[0] + idx, pos[1] + jdx]
          if pos_mov[0].between?(0,7) && pos_mov[1].between?(0,7) && board[pos_mov].color != self.color
            all_moves << pos_mov
          end
        end
      end
    end

    if is_a?(Knight)
      [-2, -1, 1, 2].each do |idx|
        [-2, -1, 1, 2].each do |jdx|
          next if idx.abs == jdx.abs
          pos_mov = [pos[0] + idx, pos[1] + jdx]
          if pos_mov[0].between?(0,7) && pos_mov[1].between?(0,7) && board[pos_mov].color != self.color
            all_moves << pos_mov
          end
        end
      end
    end

    all_moves
  end


end
