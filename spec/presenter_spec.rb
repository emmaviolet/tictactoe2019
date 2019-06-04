require_relative '../app/presenter'

RSpec.describe Presenter do

    describe '.request_next_move' do
        let(:board) { Board.new.tap { |b| b.make_play(5, 1) } }
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
        let(:board) do 
            Board.new.tap do |b| 
                b.make_play(5, 1)
                b.make_play(3, 2)
                b.make_play(1, 1)
                b.make_play(4, 2)
                b.make_play(9, 1)
            end
        end
        let(:subject) { Presenter.congratulate_winner(board) }
        
        before { allow(board).to receive(:winner).and_return(1) }

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