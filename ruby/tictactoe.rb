

class Tictactoe
  def initialize
    create_board
    display_board
    @turns = 9
    @player_1 = Player.new("X")
    @player_2 = Player.new("O") 
    @combinations_groups = {         # each position is given classifications based on winning combinations
      1 => ["r1", "c1", "d1"],       # the player wins when he/she accumulates 3 instances of a winning combination
      2 => ["r1", "c2"],            
      3 => ["r1", "c3", "d2"],       # row1, column3, diagonal2
      4 => ["r2", "c1"],
      5 => ["r2", "c2", "d1", "d2"], # row2, column2, diagonal1, diagonal2
      6 => ["r2", "c3"],
      7 => ["r3", "c1", "d2"],
      8 => ["r3", "c2"],
      9 => ["r3", "c3", "d1"]
    }
  end

  def create_board
    @board = Array.new(9, " ") 
  end

  def display_board
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "---------"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "---------"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}\n\n\n"
  end

  def play_turn(pos)
    if valid_move?(pos)
      make_move(pos)
      @turns -= 1
    else
      puts "\ninvalid move, pick again"
      display_board
    end
  end

  def make_move(pos)
    player = @turns.odd? ? @player_1 : @player_2
    groups = @combinations_groups[pos]

    mark_board(player.mark, pos)
    player.track(groups)
  end

  def valid_move?(pos)
    idx = pos - 1
    !(@board[idx] == "X" || @board[idx] == "O") && (pos <= 9 && pos >= 1) 
  end

  def mark_board(mark, pos)
    idx = pos - 1
    @board[idx] = mark
    display_board
  end

  def game_over?
    @player_1.win? || @player_2.win? || @turns == 0 
  end

  def display_winner
    if @player_1.win?
      puts "Player 1 won"
    elsif @player_2.win?
      puts "Player 2 won"
    else
      puts "It's a draw"
    end
  end
end

class Player
  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
    @combinations = Hash.new(0)
  end

  def track(groups)
    groups.each { |group| @combinations[group] += 1 }
  end

  def win?
    @combinations.has_value?(3)
  end
end


game = Tictactoe.new

until game.game_over?
  puts "Pick a position for your move (1-9)"
  move = gets.chomp.to_i
  game.play_turn(move)
end

game.display_winner


# 6, 15, 24
# 12, 15, 18