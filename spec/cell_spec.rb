require './lib/ship'
require './lib/cell'

RSpec.describe Cell do 
  before(:each) do 
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'has a coordinate' do
    expect(@cell.coordinate).to eq("B4")
  end

  describe '#empty?' do 
    it 'returns empty' do
      expect(@cell.empty?).to eq(true)
    end
  end

  describe '#place_ship' do 
    it 'places a ship' do 
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#fired upon' do
    it 'has been fired upon' do
      expect(@cell.fired_upon?).to be(false)
    end

    it 'a shot has been fired' do
      @cell.place_ship(@cruiser)
      @cell.fired_upon
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end
  end
end