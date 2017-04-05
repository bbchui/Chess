module Slidable


  def moves
    move_dirs
  end


  #private

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
    all_moves += grow_unblocked_moves_in_dir(-1, 0)[1..-1]
    all_moves += grow_unblocked_moves_in_dir(1, 0)[1..-1]
    all_moves += grow_unblocked_moves_in_dir(0, -1)[1..-1]
    all_moves += grow_unblocked_moves_in_dir(0, 1)[1..-1]
    return all_moves
  end

  def diagonal_dirs
    all_moves = []
    all_moves += grow_unblocked_moves_in_dir(1, 1)[1..-1]
    all_moves += grow_unblocked_moves_in_dir(1, -1)[1..-1]
    all_moves += grow_unblocked_moves_in_dir(-1, -1)[1..-1]
    all_moves += grow_unblocked_moves_in_dir(-1, 1)[1..-1]
    all_moves
  end


  def grow_unblocked_moves_in_dir(dx, dy)
    new_pos = [pos[0] + dx, pos[1] + dy]

    if new_pos[0] > 7 || new_pos[0] < 0 || new_pos[1] > 7 || new_pos[1] < 0
      return [[]]
    end

    curr_piece = board[new_pos]

    if !curr_piece.is_a?(NullPiece) && curr_piece.color == color
      return [[]]
    elsif !curr_piece.is_a?(NullPiece) && curr_piece.color != color
      return [[], new_pos]
    end

    dx += 1 if dx > 0
    dy += 1 if dy > 0
    dx -= 1 if dx < 0
    dy -= 1 if dy < 0

    grow_unblocked_moves_in_dir(dx, dy) << new_pos
  end

end
