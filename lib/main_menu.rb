class MainMenu
  attr_reader
  def initialize
    
    @running = true
  end
  def display_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
  end

  def run 
    display_menu
  end
end