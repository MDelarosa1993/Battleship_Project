require './lib/board'
require './lib/cell'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Board do 
  before(:each) do 
    @board = Board.new
  end

  describe '#board' do 
    it 'exists' do 
      expect(@board).to be_instance_of(Board)
    end  

    it 'has 16 cells' do
      expect(@board.cells.size).to eq(16)
    end
  
  
    it 'returns 16 objects in a hash' do 
        expect(@board.cells.values).to all(be_a(Cell))
        expect(@board.cells.size).to eq(16)
    end
  end
    
end