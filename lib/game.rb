class Game 
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end

  def setup
    puts "Setting up th egame"
    place_computer_ships
    place_player_ships
  end

  def place_computer_ships
    @computer_ships.each do |ship|
      coordinates = ["A1", "A2", "A3"]
      @computer_board.place(ship, coordinates)
    end
  end

  def place_player_ships
    @player_ships.each do |ship|
      puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
      coordinates = gets.chomp.split
      @player_board.place(ship, coordinates)
    end
  end

  def start
    puts "Game started!"
  end
end