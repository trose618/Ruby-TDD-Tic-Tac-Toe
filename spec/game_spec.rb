require "../ttt_game"

RSpec.describe TicTacToeGame do
  let(:game) { TicTacToeGame.create_game }

  describe ".create_game" do
    let(:game) { described_class.create_game }

    it "it returns a TicTacToeGame with a game board" do
      expect(game.class).to eq described_class
      expect(game.board.class).to eq TicTacToeBoard
    end

    it "it has player X as the current_player" do
      expect(game.current_player).to eql("X")
    end
  end

  describe "game behavior" do
    describe "gets a move from a player" do
      describe "#get_move" do
        let(:user_input) { "user-input\n" }
        let(:processed_input) { "user-input" }

        before :each do
          expect(STDOUT).to receive(:puts).with("Enter a move")
          expect(STDIN).to receive(:gets).and_return(user_input)
        end

        it "returns the processed user input" do
          result = game.get_move
          expect(result).to eql(processed_input)
        end
      end
    end

    describe "check if a move is legal" do
      describe "#legal_move?" do
        context "given a valid coordinate" do
          let(:move) { "0 0" }
          it "returns true" do
            result = game.legal_move?(move)
            expect(result).to eq true
          end
        end

        context "given an invalid input" do
          context "input is empty" do
            let(:move) { "" }
            it "returns false" do
              result = game.legal_move?(move)
              expect(result).to eq false
            end
          end

          context "input length is not 3" do
            let(:move) { "0   0" }
            it "returns false" do
              result = game.legal_move?(move)
              expect(result).to eq false
            end
          end

          context "input overlaps an existent piece" do
            let(:move) { "0 0" }
            before :each do game.place_piece(move) end
            it "returns false" do
              result = game.legal_move?(move)
              expect(result).to eq false
            end
          end

          context "input coordinates are out of bounds" do
            let(:move) { "-1 9" }
            it "returns false" do
              result = game.legal_move?(move)
              expect(result).to eq false
            end
          end
        end
      end
    end

    describe "switches to the next player if game is not over" do
      context "given current player is X" do
        it "changes current player to O" do
          game.change_players
          expect(game.current_player).to eql("O")
        end
      end

      context "given current player is O" do
        before :each do
          game.set_player_to "O"
          game.change_players
        end
        it "changes current player to X" do
          expect(game.current_player).to eql("X")
        end
      end
    end

    describe "toggles game in progress" do
      context "game starts" do
        before :each do
          game.set_game_in_progress_to true
        end
        it "changes game_in_progress to true" do
          expect(game.game_in_progress).to eq true
        end
      end
    end
  end

  describe "#play_game" do
  end
end
