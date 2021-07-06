require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.won? && evaluator != @board.winner if @board.over?
    return children.all? { |child| child.losing_node?(evaluator) } if evaluator == @next_mover_mark
    children.any? { |child| child.losing_node?(evaluator) }
  end

  def winning_node?(evaluator)
    return @board.won? && evaluator == @board.winner if @board.over?
    return children.any? { |child| child.winning_node?(evaluator) } if evaluator == @next_mover_mark
    children.all? { |child| child.winning_node?(evaluator) }
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |i|
      (0..2).each do |j|
        pos = [i, j]
        next if !@board.empty?(pos)
        new_board = @board.dup
        new_board[pos] = @next_mover_mark
        next_mark = @next_mover_mark == :o ? :x : :o
        children << TicTacToeNode.new(new_board, next_mark, pos)
      end
    end
    children
  end
end
