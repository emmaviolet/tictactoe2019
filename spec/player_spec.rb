# frozen_string_literal: true

require_relative '../app/player'

RSpec.describe Player do
    describe '.initialize' do
        specify { expect(Player.new('Player 1').title).to eq('Player 1') }
    end

    describe '#icon' do
        specify { expect(Player.new('Player 1').icon).to eq('O') }
        specify { expect(Player.new('Player 2').icon).to eq('X') }
    end
end
