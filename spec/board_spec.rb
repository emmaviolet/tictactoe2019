# frozen_string_literal: true

require_relative '../app/board'

RSpec.describe Play do
    let(:player) { Player.new('Player 1') }

    describe '.initialize' do
        specify { expect(Play.new(3, player).position).to eq(3) }
        specify { expect(Play.new(9, player).player).to eq(player) }
    end
end

RSpec.describe Board do
    let(:board) { Board.new }
    let(:player_1) { Player.new('Player 1') }
    let(:player_2) { Player.new('Player 2') }
    let(:players) { [player_1, player_2] }

    before { allow(board).to receive(:players).and_return(players) }

    describe '.initialize' do
        specify { expect(board.winner).to eq(nil) }
    end

    describe '#make_play' do
        describe 'when the position given is invalid' do
            let(:error) { 'Position 10 is not a valid position' }
            let(:subject) { board.make_play(10, player_1) }

            specify { expect { subject }.to raise_error(error) }
        end

        describe 'when the position given has already been played' do
            let(:error) { 'Position 5 is not available' }
            let(:subject) { board.make_play(5, player_2) }

            before { board.make_play(5, player_1) }

            specify { expect { subject }.to raise_error(error) }
        end

        describe 'when the player given is not the current player' do
            let(:error) { 'It is not Player 1\'s turn' }
            let(:subject) { board.make_play(7, player_1) }

            before { board.make_play(3, player_1) }

            specify { expect { subject }.to raise_error(error) }
        end

        describe 'when the position and the player are valid inputs' do
            let(:subject) { board.make_play(7, player_1) }

            specify { expect { subject }.not_to raise_error }

            describe 'and the play is not a winning play' do
                let(:subject) { board.make_play(3, player_1) }

                specify { expect { subject }.not_to change { board.winner } }
            end

            describe 'and the play is a winning play' do
                let(:subject) { board.make_play(3, player_1) }

                before do
                    board.make_play(1, player_1)
                    board.make_play(5, player_2)
                    board.make_play(2, player_1)
                    board.make_play(4, player_2)
                end

                specify do
                    expect { subject }.to change { board.winner }
                        .from(nil).to(player_1)
                end
            end
        end
    end

    describe '#grid' do
        before do
            board.make_play(1, player_1)
            board.make_play(5, player_2)
            board.make_play(2, player_1)
        end

        let(:expected_grid) { [['O', 'O', 3], [4, 'X', 6], [7, 8, 9]] }

        specify { expect(board.grid).to eq(expected_grid) }
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

    describe '#won?' do
        describe 'when the board has a winner' do
            before { allow(board).to receive(:winner).and_return(player_1) }

            specify { expect(board.won?).to eq(true) }
        end

        describe 'when the board does not have a winner' do
            before { allow(board).to receive(:winner).and_return(nil) }

            specify { expect(board.won?).to eq(false) }
        end
    end
end
