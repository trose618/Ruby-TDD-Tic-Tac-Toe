require "../ttt_board"

RSpec.describe TicTacToeBoard do
  let(:board) { TicTacToeBoard.create_empty_board }
  let(:coords) { [0, 0] }

  describe "is_full?" do
    context "given a non full board" do
      before :each do
        board.preset(["X", "-", "O", "-", "O", "X", "-", "O", "X"])
      end

      let(:result) { board.is_full? }
      it "return false" do
        expect(result).to eq false
      end
    end

    context "given a full board" do
      before :each do
        board.preset(["X", "X", "O", "O", "O", "X", "X", "O", "X"])
      end
      let(:result) { board.is_full? }
      it "returns true" do
        expect(result).to eq true
      end
    end
  end

  describe "#preset" do
    it "presets the board according to params" do
      result = [%w[X - -], %w[- X -], %w[- - X]]
      board.preset(["X", "-", "-", "-", "X", "-", "-", "-", "X"])
      expect(board.get_piece_at(coords)).to eql("X")
      expect(board.get_piece_at([1, 1])).to eql("X")
      expect(board.get_piece_at([2, 2])).to eql("X")
    end
  end

  describe "board behavior" do
    it "is empty to start" do
      expect(board.empty?).to eq true
    end

    it "is not empty after you add a piece" do
      board.add_piece(coords, "X")
      expect(board.empty?).to eq false
    end

    context "given an empty board" do
      it "returns a piece at a given location as '-'" do
        expect(board.get_piece_at(coords)).to eq "-"
      end
      it "adds X in position 0,0 (top left) when given coords 0,0" do
        board.add_piece(coords, "X")
        expect(board.get_piece_at(coords)).to eq "X"
      end

      it "adds multiple pieces in different parts of the board" do
        board.add_piece(coords, "X")
        board.add_piece([2, 2], "O")
        expect(board.get_piece_at(coords)).to eq "X"
        expect(board.get_piece_at([2, 2])).to eq "O"
      end
    end

    context "given a non empty board with a piece at 0 0" do
      before :each do
        board.add_piece(coords, "X")
      end
      it "does not allow player pieces to overlap" do
        board.add_piece(coords, "O")
        expect(board.get_piece_at(coords)).to eq "X"
      end

      it "resets by clearing all pieces from the board" do
        board.reset
        expect(board.empty?).to eq true
      end

      let(:other_coords) { [0, 1] }

      it "tells you if board is empty at given coordinates" do
        expect(board.spot_is_empty?(coords)).to eq false
        expect(board.spot_is_empty?(other_coords)).to eq true
      end
    end

    describe "#get_piece_at" do
      context "given valid input" do
        let(:coords) { [0, 0] }
        it "does not raise in error" do
          board.add_piece(coords, "X")
          expect { board.get_piece_at(coords) }.to_not raise_error
        end
      end
    end

    describe "outputs the board to the console" do
      context "given an empty board" do
        let(:board_output) { "\n  - | - | - \n ----------- \n  - | - | - \n ----------- \n  - | - | -\n" }
        it "prints a 3x3 matrix of '-'" do
          expect { board.print_board }.to output(board_output).to_stdout
        end
      end

      context "given a board with X at 0 0" do
        let(:board_output_2) { "\n  X | - | - \n ----------- \n  - | - | - \n ----------- \n  - | - | -\n" }
        let(:coords) { [0, 0] }
        before :each do
          board.add_piece(coords, "X")
        end
        it "prints 3x3 matrix with X at 0 0 and '-' everywhere else" do
          expect { board.print_board }.to output(board_output_2).to_stdout
        end
      end
    end

    describe "#tie_game?" do
      context "given a full board with no winner" do
        before :each do
          board.preset(["X", "X", "O", "O", "O", "X", "X", "O", "X"])
        end
        let(:result) { board.tie_game? }
        it "returns true" do
          expect(result).to eq true
        end
      end

      context "given a non full board with no winner" do
        before :each do
          board.preset(["X", "-", "O", "-", "O", "X", "-", "O", "X"])
        end
        let(:result) { board.tie_game? }
        it "returns false" do
          expect(result).to eq false
        end
      end
    end

    describe "board checks if there is winning case" do
      context "non winning case" do
        it "returns false" do
          result = board.winner?
          expect(result).to eq false
        end
      end

      context "winning case" do
        context "top row" do
          before :each do
            board.preset(["X", "X", "X", "-", "-", "-", "-", "-", "-"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "mid row" do
          before :each do
            board.preset(["-", "-", "-", "X", "X", "X", "-", "-", "-"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "bottom row" do
          before :each do
            board.preset(["-", "-", "-", "-", "-", "-", "X", "X", "X"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "left col" do
          before :each do
            board.preset(["X", "-", "-", "X", "-", "-", "X", "-", "-"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "mid col" do
          before :each do
            board.preset(["-", "X", "-", "-", "X", "-", "-", "X", "-"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "right col" do
          before :each do
            board.preset(["-", "-", "X", "-", "-", "X", "-", "-", "X"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "top right to bottom left diagnal" do
          before :each do
            board.preset(["-", "-", "X", "-", "X", "-", "X", "-", "-"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
        context "top left to bottom right diagnal" do
          before :each do
            board.preset(["X", "-", "-", "-", "X", "-", "-", "-", "X"])
          end
          it "returns true" do
            result = board.winner?
            expect(result).to eq true
          end
        end
      end
    end
  end
end
