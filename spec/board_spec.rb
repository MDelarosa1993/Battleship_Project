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

  describe '#Validating coordinates' do
    it 'is it a valid coordinate?' do
      expect(@board.valid_coordinate?("A1")).to be(true)
      expect(@board.valid_coordinate?("D4")).to be(true)
      expect(@board.valid_coordinate?("A5")).to be(false)
      expect(@board.valid_coordinate?("E1")).to be(false)
      expect(@board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe '#valid_placement?' do
    it 'is it a valid placement?' do
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)

      
    end
  end
end