require_relative '../app/runner'

RSpec.describe Runner do
    let(:board) { Board.new }
    let(:runner) { Runner.new }
    let(:player_1) { Player.new('Player 1') }
    let(:player_2) { Player.new('Player 2') }

    before do
        allow(Board).to receive(:new).and_return(board)
        allow(Runner).to receive(:new).and_return(runner)

        allow(Presenter).to receive(:congratulate_winner)
        allow(Presenter).to receive(:request_next_move)
    end

    before(:each) do
        allow(runner).to receive(:gets).and_return('1', '2', '4', '3', '7')

        allow(board).to receive(:current_player).and_return(player_1, player_2, player_1, player_2, player_1)
        allow(board).to receive(:is_won?).and_return(false, false, false, false, false, true)
        allow(board).to receive(:make_play)
    end

    describe '.play' do
        describe 'when the board is in play' do
            before { allow(board).to receive(:make_play) }

            it 'requests a new move' do
                expect(Presenter).to receive(:request_next_move).with(board)
                Runner.play
            end

            it 'updates the board with the inputted position' do
                expect(board).to receive(:make_play).with(1, player_1)
                Runner.play
            end
        end

        describe 'when the board is won' do
            before { allow(board).to receive(:make_play) }

            it 'congratulates the winner' do
                expect(board).to receive(:make_play).exactly(5).times
                expect(Presenter).to receive(:congratulate_winner).with(board)
                Runner.play
            end
        end

        describe 'when an invalid move is played' do
            before do
                # raise error on first pass
                allow(board).to receive(:make_play) do |position|
                    raise 'Bad move' if position == 1
                end
            end

            specify { expect { Runner.play }.to output("Bad move\n").to_stdout }
        end
    end
end