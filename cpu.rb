class Cpu

  def initialize(cpu_side)
    @cpu_side = cpu_side
    @opponent = cpu_side == :circle ? :cross : :circle
  end

  # 評価関数
  def evaluate(board)
    case board.winner
    when @cpu_side then 1
    when @opponent then -1
    else 0
    end
  end

  # CPUの手番の最善手のボードと評価値を返す
  def cpu_phase(board)
    value = -2
    next_board = nil

    # CPUの次の一手を全検索する
    board.each_with_index do |square, i|
      next if square != :free
      board[i] = @cpu_side
      v = evaluate(board)

      # 続きが打てる場合は相手の一手を考える
      v = opponent_phase(board)[1] if v == 0 && !board.draw?

      # 検索した他の手よりも評価値が大きい場合は保存する
      if v > value
        value = v
        next_board = board.deep_dup
      end

      # ボードを元に戻す
      board[i] = :free
    end

    # 最善手とその評価値を返す
    [next_board, value]
  end

  # 相手の手番の最善手のボードと評価値を返す
  def opponent_phase(board)
    value = 2
    next_board = nil

    # 相手の次の一手を全検索する
    board.each_with_index do |square, i|
      next if square != :free
      board[i] = @opponent
      v = evaluate(board)

      # 続きが打てる場合は相手の一手を考える
      v = cpu_phase(board)[1] if v == 0 && !board.draw?

      # 検索した他の手よりも評価値が小さい場合は保存する
      if v < value
        value = v
        next_board = board.deep_dup
      end

      # ボードを元に戻す
      board[i] = :free
    end

    [next_board, value]
  end
end
