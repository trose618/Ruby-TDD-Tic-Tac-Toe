class TicTacToeBoard
  attr_reader :board

  def initialize
    @board = [%w[- - -], %w[- - -], %w[- - -]]
  end

  def self.create_empty_board
    TicTacToeBoard.new
  end

  def empty?
    board.each { |row| row.each { |col| return false if col != "-" } }
    true
  end

  def add_piece(coords, piece)
    board[coords[0]][coords[1]] = piece if get_piece_at(coords) == "-"
  end

  def get_piece_at(coords)
    board[coords[0].to_i][coords[1].to_i]
  end

  def reset
    board = [%w[- - -], %w[- - -], %w[- - -]]
  end

  def spot_is_empty?(coords)
    get_piece_at(coords) == "-"
  end

  def print_board
    output = "\n  #{board[0].join(" | ")} \n ----------- \n  #{board[1].join(" | ")} \n ----------- \n  #{board[2].join(" | ")}"
    puts output
  end

  def preset(params)
    @board[0][0] = params[0]
    @board[0][1] = params[1]
    @board[0][2] = params[2]
    @board[1][0] = params[3]
    @board[1][1] = params[4]
    @board[1][2] = params[5]
    @board[2][0] = params[6]
    @board[2][1] = params[7]
    @board[2][2] = params[8]
  end

  def is_full?
    board.each do |row|
      row.each do |col|
        return false if col == "-"
      end
    end
    true
  end

  def winner?
    WinningCases.win_by_row?(self) ||
      WinningCases.win_by_col?(self) ||
      WinningCases.win_by_diagnal?(self)
  end

  def tie_game?
    is_full?
  end

  def all_same_piece?(positions)
    positions.map do |x, y|
      get_piece_at([x, y])
    end.uniq.length == 1
  end

  private

  attr_reader :board

  class WinningCases
    def self.win_by_row?(board)
      first_row = [[0, 0], [0, 1], [0, 2]]
      first_row_same = !board.spot_is_empty?(first_row.first) &&
                       board.all_same_piece?(first_row)

      second_row = [[1, 0], [1, 1], [1, 2]]
      second_row_same = !board.spot_is_empty?(second_row.first) &&
                        board.all_same_piece?(second_row)

      third_row = [[2, 0], [2, 1], [2, 2]]
      third_row_same = !board.spot_is_empty?(third_row.first) &&
                       board.all_same_piece?(third_row)

      first_row_same || second_row_same || third_row_same
    end

    def self.win_by_col?(board)
      first_col = [[0, 0], [1, 0], [2, 0]]
      first_col_same = !board.spot_is_empty?(first_col.first) &&
                       board.all_same_piece?(first_col)

      second_col = [[0, 1], [1, 1], [2, 1]]
      second_col_same = !board.spot_is_empty?(second_col.first) &&
                        board.all_same_piece?(second_col)

      third_col = [[0, 2], [1, 2], [2, 2]]
      third_col_same = !board.spot_is_empty?(third_col.first) &&
                       board.all_same_piece?(third_col)

      first_col_same || second_col_same || third_col_same
    end

    def self.win_by_diagnal?(board)
      first_diagnal = [[0, 0], [1, 1], [2, 2]]

      first_diagnal_same = !board.spot_is_empty?(first_diagnal.first) &&
                           board.all_same_piece?(first_diagnal)

      second_diagnal = [[0, 2], [1, 1], [2, 0]]

      second_diagnal_same = !board.spot_is_empty?(second_diagnal.first) &&
                            board.all_same_piece?(second_diagnal)

      first_diagnal_same || second_diagnal_same
    end
  end
end
