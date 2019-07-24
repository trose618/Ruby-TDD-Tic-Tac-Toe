require_relative "./ttt_board"

class TicTacToeGame
  attr_accessor :board, :current_player, :game_in_progress

  def initialize
    @board = TicTacToeBoard.create_empty_board
    @current_player = "X"
    @game_in_progress = false
  end

  def self.create_game
    TicTacToeGame.new
  end

  def get_move
    STDOUT.puts "Enter a move"
    STDIN.gets.chomp
  end

  def legal_move?(move)
    return false if move.length != 3
    board.spot_is_empty?([move[0], move[2]])
  end

  def place_piece(move)
    board.add_piece([move[0].to_i, move[2].to_i], current_player)
  end

  def change_players
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def set_player_to(player)
    @current_player = player
  end

  def print_board
    board.print_board
  end

  def set_game_in_progress_to(state)
    @game_in_progress = state
  end

  def winner?
    board.winner?
  end

  def tie_game?
    return true if board.is_full?
    false
  end

  def play_game
    #
    game_in_progress = true
    board.print_board
    while game_in_progress
      line
      legal = false
      #repeatedly get move
      while legal == false
        puts "Player #{current_player}'s turn.'"
        move = get_move
        legal = legal_move?(move)
      end

      #update
      place_piece move
      print_board

      #check for end state?
      if winner?
        game_in_progress = false
        winner_message
      elsif tie_game?
        game_in_progress = false
        tie_game_message
      else
        change_players
      end
    end
  end

  def winner_message
    puts "The winner is player #{current_player}!"
  end

  def tie_game_message
    puts "Tie game!"
  end

  def line
    puts "*" * 30
  end

  private
end
