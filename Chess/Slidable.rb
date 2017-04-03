module Slidable


  def moves
    move_dirs
  end

  private

  def move_dirs
    if is_a?(Queen)
      return horizontal_dirs + diagonal_dirs
    elsif is_a?(Rook)
      return horizontal_dirs
    elsif is_a?(Bishop)
      diagonal_dirs
    end
  end

  def horizontal_dirs
    all_moves = []
    all_moves += grow_unblocked_moves_in_dir(-1, 0)
    all_moves += grow_unblocked_moves_in_dir(1, 0)
    all_moves += grow_unblocked_moves_in_dir(0, -1)
    all_moves += grow_unblocked_moves_in_dir(0, 1)
    all_moves
  end

  def diagonal_dirs
    all_moves = []
    all_moves += grow_unblocked_moves_in_dir(1, 1)
    all_moves += grow_unblocked_moves_in_dir(1, -1)
    all_moves += grow_unblocked_moves_in_dir(-1, -1)
    all_moves += grow_unblocked_moves_in_dir(-1, 1)
    all_moves
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    new_pos = [pos[0] + dx, pos[1] + dy]
    curr_piece = board[new_pos]

    if curr_piece.is_a?(NullPiece) && curr_piece.color == color
      return
    elsif curr_piece.is_a?(NullPiece) && curr_piece.color != color
      return curr_piece.pos
    end

    dx += 1 if dx > 0
    dy += 1 if dy > 0
    dx -= 1 if dy < 0
    dy -= 1 if dy < 0

    grow_unblocked_moves_in_dir(dx, dy) + curr_piece.pos
  end

end
