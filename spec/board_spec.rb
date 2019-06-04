require_relative '../app/board'

RSpec.describe Board do
    let(:board) { Board.new }
    let(:player_1) { Player.new('Player 1') }
    let(:player_2) { Player.new('Player 2') }

    before { allow(board).to receive(:players).and_return([player_1, player_2]) }

    describe '.initialize' do
        specify { expect(board.winner).to eq(nil) }
    end

    describe '#make_play' do
        describe 'when the position given is invalid' do
            specify { expect { board.make_play(10, player_1) }.to raise_error('Position 10 is not a valid position') }
        end

        describe 'when the position given has already been played' do
            before { board.make_play(5, player_1) }

            specify { expect { board.make_play(5, player_2) }.to raise_error('Position 5 is not available') }
        end

        describe 'when the player given is not the current player' do
            before { board.make_play(3, player_1) }

            specify { expect { board.make_play(7, player_1) }.to raise_error('It is not Player 1\'s turn') }
        end

        describe 'when the position and the player are valid inputs' do
            specify { expect { board.make_play(7, player_1) }.not_to raise_error }

            describe 'and the play is not a winning play' do
                specify { expect { board.make_play(3, player_1) }.not_to change { board.winner } }
            end

            describe 'and the play is a winning play' do
                before do
                    board.make_play(1, player_1)
                    board.make_play(5, player_2)
                    board.make_play(2, player_1)
                    board.make_play(4, player_2)
                end

                specify { expect { board.make_play(3, player_1) }.to change { board.winner }.from(nil).to(player_1) }
            end
        end
    end

    describe '#grid' do
        before do
            board.make_play(1, player_1)
            board.make_play(5, player_2)
            board.make_play(2, player_1)
        end

        specify { expect(board.grid).to eq([ ['O', 'O', 3], [4, 'X', 6], [7, 8, 9] ]) }
    end

    describe '#current_player' do
        describe 'when no plays have yet been made' do
            specify { expect(board.current_player).to eq(player_1) }
        end

        describe 'when plays have been made' do
            before { board.make_play(5, player_1) }

            specify { expect(board.current_player).to eq(player_2) }
        end
    end

    describe '#is_won?' do
        describe 'when the board has a winner' do
            before { allow(board).to receive(:winner).and_return(player_1) }

            specify { expect(board.is_won?).to eq(true) }
        end

        describe 'when the board does not have a winner' do
            before { allow(board).to receive(:winner).and_return(nil) }

            specify { expect(board.is_won?).to eq(false) }
        end
    end
end