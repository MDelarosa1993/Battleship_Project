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
    
  end



end