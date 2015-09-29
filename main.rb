require './board.rb'
require './cpu.rb'

def input_player_choice
  puts ''
  puts '次の手を入力してください'
  @board.puts_state

  choice = gets.chop.to_i
  @board[choice] = @player_side
  @board.puts_state

  if @board.draw?
    puts 'ひきわけ'
  elsif @board.winner == @player_side
    puts 'あなたのかちです'
  else
    input_cpu_choice
  end
end

def input_cpu_choice
  puts ''
  puts 'CPUの手番です'

  @board, value = @cpu.cpu_phase(@board)
   if @board.draw?
    puts 'ひきわけ'
  elsif @board.winner == @cpu_side
    puts 'あなたのまけです'
    @board.puts_state
  else
    input_player_choice
  end
end

puts '先手後手を選んでください'
puts '0: マル(先手)'
puts '1: バツ(後手)'

player = gets.chop

if player == '0'
  @player_side = :circle
  @cpu_side = :cross
elsif player == '1'
  @player_side = :cross
  @cpu_side = :circle
else
  exit
end

@cpu = Cpu.new(@cpu_side)

@board = Board.new

if @player_side == :circle
  input_player_choice
else
  input_cpu_choice
end
