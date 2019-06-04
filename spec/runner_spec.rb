require_relative '../app/runner'

RSpec.describe Runner do
    let(:board_double) { double(:board, is_won?: true) }

    before do 
        allow(Board).to receive(:new).and_return(board_double)
        allow(Presenter).to receive(:congratulate_winner)
        allow(Presenter).to receive(:request_next_move)
    end

    describe '.play' do
        it 'creates a new board instance' do
            expect(Board).to receive(:new)
            Runner.play
        end
    end
end