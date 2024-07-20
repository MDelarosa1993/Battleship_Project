require './lib/ship'
require './lib/cell'

RSpec.configure do |config|
  config.formatter = :documentation
end

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

  describe 'can render' do
    xit 'shows . for cell not fired upon' do 
      expect(@cell.render).to eq(".")
    end
    
    xit 'shows M for a missed shot' do
      expect(@cell.render).to eq("M")
    end

    xit 'shows H for a hit' do 
      expect(@cell.render).to eq("H")
    end

    xit 'shows X on sunk ship cells' do
      expect(@cell.render).to eq("X")
    end

    it 'shows S for revealed ship' do 
      @cell.place_ship(@cruiser)
      expect(@cell.render (true)).to eq("S")
    end
  end
end