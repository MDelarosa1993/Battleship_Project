require './lib/ship'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Ship do 
  before(:each) do 
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe 'Initialize' do 
    it 'exists' do 
      expect(@cruiser).to be_an_instance_of(Ship)
    end
    
    it 'has a name' do 
      expect(@cruiser.name).to eq ("Cruiser")
    end

    it 'has length' do 
      expect(@cruiser.length).to eq(3)
    end

    it 'has health' do
      expect(@cruiser.health).to eq(3)
    end

    it 'has not sunk' do
      expect(@cruiser.sunk?).to be false
    end

    it 'has taken a hit' do
      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end

    it 'can be sunk' do
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to eq(true)
    end
  end
end