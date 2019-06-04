require_relative '../app/board'

RSpec.describe Board do
    let(:board) { Board.new }

    describe '.initialize' do
        specify { expect(board.plays).to eq([]) }
        specify { expect(board.winner).to eq(nil) }
    end

    describe '#make_play' do
        describe 'when the position given is invalid' do
            specify { expect { board.make_play(10, 1) }.to raise_error('Position 10 is not a valid position') }
        end

        describe 'when the position given has already been played' do
            before { board.make_play(5, 1) }

            specify { expect { board.make_play(5, 2) }.to raise_error('Position 5 is not available') }
        end

        describe 'when the player given is not the current player' do
            before { board.make_play(3, 1) }

            specify { expect { board.make_play(7, 1) }.to raise_error('It is not Player 1\'s turn') }
        end

        describe 'when the position and the player are valid inputs' do
            specify { expect { board.make_play(6, 1) }.to change { board.plays.count }.by(1) }

            it 'adds the expected play to the array of plays' do
                board.make_play(5, 1)
                expect(board.plays.last.position).to eq(5)
                expect(board.plays.last.player).to eq(1)
            end
        end
    end

    describe '#current_player' do
        describe 'when no plays have yet been made' do
            specify { expect(board.current_player).to eq(1) }
        end

        describe 'when plays have been made' do
            before { board.make_play(5, 1) }

            specify { expect(board.current_player).to eq(2) }
        end
    end

    describe '#is_won?' do
        describe 'when no plays have yet been made' do
            specify { expect(board.is_won?).to eq(false) }
            specify { expect { board.is_won? }.not_to change { board.winner } }
        end

        describe 'when plays have been made' do
            describe 'and the last player does not a winning streak' do
                before do 
                    board.make_play(5, 1)
                    board.make_play(1, 2)
                    board.make_play(4, 1)
                    board.make_play(2, 2)
                    board.make_play(3, 1)
                end

                specify { expect(board.is_won?).to eq(false) }
                specify { expect { board.is_won? }.not_to change { board.winner } }
            end

            describe 'and the last player has a winning streak' do
                before do 
                    board.make_play(5, 1)
                    board.make_play(1, 2)
                    board.make_play(4, 1)
                    board.make_play(2, 2)
                    board.make_play(6, 1)
                end

                specify { expect(board.is_won?).to eq(true) }
                specify { expect { board.is_won? }.to change { board.winner }.from(nil).to(1) }
            end
        end
    end
end