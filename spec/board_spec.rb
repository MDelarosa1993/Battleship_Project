require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Board do 
  before(:each) do 
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
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
    end

    it 'is not a valid coordinate' do
      expect(@board.valid_coordinate?("A5")).to be(false)
      expect(@board.valid_coordinate?("E1")).to be(false)
      expect(@board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe '#valid_placement?' do
    it 'is the same length of the ship' do
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be (false)
    end

    it 'returns consecutive coordinates' do 
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be (false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be (false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be (false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be (false)
    end

    it 'cant be diagonal' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be (false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be (false)
    end

    it 'returns placement is valid' do 
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be (true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be (true)
    end
  end

  describe '#Place' do 
    it 'places a ship on a cell' do 
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["A2"].ship).to eq(@cruiser)
      expect(@board.cells["A3"].ship).to eq(@cruiser)
      expect(@board.cells["A1"].ship).to be(@board.cells["A2"].ship)
      expect(@board.cells["A2"].ship).to be(@board.cells["A3"].ship)
    end
  end

  describe '#overlapping?' do 
    it 'test that ships overlap' do 
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be(false)
   end
  end

  describe '#render' do
    it 'renders without showing ships' do
      expect(@board.render).to eq("  1 2 3 4 \n" +
                                   "A . . . . \n" +
                                   "B . . . . \n" +
                                   "C . . . . \n" +
                                   "D . . . . \n")
    end

    it 'renders the board showing ships' do
      @cruiser = Ship.new("Cruiser", 3)
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.render(true)).to eq("  1 2 3 4 \n" +
                                         "A S S S . \n" +
                                         "B . . . . \n" +
                                         "C . . . . \n" +
                                         "D . . . . \n")
    end

    it 'renders hits, misses, and sunken ships' do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.cells["A1"].fire_upon
      @board.cells["A2"].fire_upon
      @board.cells["B2"].fire_upon
      @board.cells["A3"].fire_upon
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@board.render).to eq("  1 2 3 4 \n" +
                                  "A X X X . \n" +
                                  "B . M . . \n" +
                                  "C . . . . \n" +
                                  "D . . . . \n")
    end
  end
end