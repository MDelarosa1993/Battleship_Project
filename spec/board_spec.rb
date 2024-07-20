require './lib/board'
require './lib/cell'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Board do 
  before(:each) do 
    @board = Board.new
  end

  describe '#board cells' do 
    it 'exists' do 
      expect(@board).to be_instance_of(Board)
    end

    it 'returns a hash of 16 objects' do 
      expect(@board.cells).to be_a(Hash) 
    end
  end
end