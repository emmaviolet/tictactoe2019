require_relative '../app/play'

RSpec.describe Play do

    describe '.initialize' do
        specify { expect(Play.new(3, 1).position).to eq(3) }
        specify { expect(Play.new(9, 2).player).to eq(2) }
    end
end
