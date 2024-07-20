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
end