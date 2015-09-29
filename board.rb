require 'forwardable'

class Board
  extend Forwardable
  attr_accessor :state

  def_delegators :@state, :[], :[]=, :each_with_index

  def initialize
    @state = [:free, :free, :free,
              :free, :free, :free,
              :free, :free, :free]
  end

  def deep_dup
    board = Board.new
    board.state = @state.dup
    board
  end

  # ゲームに勝利できる並び
  LINE = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [2,4,6]
  ]

  def winner
    LINE.each do |squares|
      # 盤面から検索するラインの状態を取得する
      first_square  = @state[squares[0]]
      second_square = @state[squares[1]]
      third_square  = @state[squares[2]]

      # 勝利条件を満たさない場合
      next if first_square == :free
      next if first_square != second_square
      next if first_square != third_square

      return first_square
    end

    return nil
  end

  def draw?
    @state.each {|s| return false if s == :free }
    return true
  end

  def puts_state
    display = @state.map.with_index do |s, i|
      case s
        when :circle then 'o'
        when :cross then 'x'
        else i.to_s
      end
    end

    (0..2).each {|i| puts display[i*3] + display[i*3+1]+ display[i*3+2]}
  end
end
