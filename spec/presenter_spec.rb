require_relative '../app/presenter'

RSpec.describe Presenter do
    let(:player_1) { Player.new('Player 1') }
    let(:player_2) { Player.new('Player 2') }
    let(:board) { Board.new }

    before do
        allow(board).to receive(:players).and_return([player_1, player_2])
        board.make_play(5, player_1)
    end

    describe '.request_next_move' do
        let(:subject) { Presenter.request_next_move(board) }
        
        it 'prints the expected to STDOUT' do
            expected_output = [
                'Player 2, pick a play:',
                '           |           |           ',
                '     1     |     2     |     3     ',
                '           |           |           ',
                '-----------------------------------',
                '           |           |           ',
                '     4     |     O     |     6     ',
                '           |           |           ',
                '-----------------------------------',
                '           |           |           ',
                '     7     |     8     |     9     ',
                '           |           |           ',
                "Play position:\n"
            ].join("\n")

            expect { subject }.to output(expected_output).to_stdout
        end
    end

    describe '.congratulate_winner' do
        before do 
            board.make_play(3, player_2)
            board.make_play(1, player_1)
            board.make_play(4, player_2)
            board.make_play(9, player_1)
        end
        let(:subject) { Presenter.congratulate_winner(board) }

        it 'prints the expected to STDOUT' do
            expected_output = [
                'Congratulations, Player 1, you have won!',
                '***********************************',
                '           |           |           ',
                '     O     |     2     |     X     ',
                '           |           |           ',
                '-----------------------------------',
                '           |           |           ',
                '     X     |     O     |     6     ',
                '           |           |           ',
                '-----------------------------------',
                '           |           |           ',
                '     7     |     8     |     O     ',
                '           |           |           ',
                "***********************************\n"
            ].join("\n")

            expect { subject }.to output(expected_output).to_stdout
        end
    end
end