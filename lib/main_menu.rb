class MainMenu
  attr_reader
  def initialize
    
    @running = true
  end
  def display_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit"
  end

  def play_game
    game = Game.new
    game.setup
    game.start
  end

  def exit_game
    puts "Exiting BATTLESHIP"
    @running = false
  end

  def run 
    display_menu
    puts "Enter your choice"
    choice = gets.chomp.downcase 

    if choice == "p"
      play_game
    elsif choice == "q"
      exit_game
    else 
      puts "Invaild choice. Please try again."
    end
  end
end