require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/main_menu'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe MainMenu do 
   before(:each) do
  
  end

  describe 'Main Menu' do
    it 'displays main menu' do
      # allow(@game).to receive(:gets).and_return('p')
    end
  end
end