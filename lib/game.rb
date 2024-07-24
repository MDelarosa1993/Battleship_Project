require './lib/board'
require './lib/cell'
require './lib/ship'
class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    loop do
      puts "Enter 'p' to play. Enter 'q' to quit."
      input = gets.chomp.downcase
      case input
      when 'p'
        setup
        play_game
      when 'q'
        puts "Goodbye!"
        exit
      else
        puts "Invalid input. Please enter 'p' or 'q'."
      end
    end
  end

  def setup
    puts "Setting up the game..."
    place_computer_ships
    place_player_ships
  end

  def place_computer_ships
    @computer_ships.each do |ship|
      placed = false
      until placed
        coordinates = generate_random_coordinates(ship.length)
        if @computer_board.valid_placement?(ship, coordinates)
          @computer_board.place(ship, coordinates)
          placed = true
        end
      end
    end
  end

  def place_player_ships
    @player_ships.each do |ship|
      valid_placement = false
      until valid_placement
        puts "I have laid out my ships on the grid."
        puts "You now need to lay out your #{ship.name} (#{ship.length} spaces)."
        puts @player_board.render(true)
        puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
        coordinates = gets.chomp.split.map(&:upcase)
        if @player_board.valid_placement?(ship, coordinates)
          @player_board.place(ship, coordinates)
          valid_placement = true
        else
          puts "Those are invalid coordinates. Please try again."
        end
      end
    end
  end

  def play_game
    loop do
      display_boards(false) # Show player's board with their ships
      player_turn
      break if game_over?

      display_boards(false) # Show computer's board without revealing their ships
      computer_turn
      break if game_over?
    end
    display_boards(true) # Final display of boards after game ends
    announce_winner
    main_menu
  end

  def display_boards(reveal_computer_ships = false)
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(reveal_computer_ships)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)  # Always reveal player's ships
  end

  def player_turn
    puts "============== PLAYER TURN =============="
    coordinate = get_player_coordinate
    result = @computer_board.cells[coordinate].fire_upon
    puts "Your shot on #{coordinate} was #{result}."
  end

  def get_player_coordinate
    loop do
      puts "Enter the coordinate for your shot (e.g., A1):"
      coordinate = gets.chomp.upcase
      if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
        return coordinate
      else
        puts "Please enter a valid coordinate that you haven't fired on."
      end
    end
  end

  def computer_turn
    puts "============== COMPUTER TURN =============="
    coordinate = random_coordinate_to_fire
    result = @player_board.cells[coordinate].fire_upon
    puts "My shot on #{coordinate} was #{result}."
  end

  def random_coordinate_to_fire
    available_coordinates = @player_board.cells.keys.select { |coordinate| !@player_board.cells[coordinate].fired_upon? }
    random_index = rand(available_coordinates.length)
    available_coordinates[random_index]
  end

  def game_over?
    @player_ships.all? { |ship| ship.sunk? } || @computer_ships.all? { |ship| ship.sunk? }
  end

  def announce_winner
    if @computer_ships.all? { |ship| ship.sunk? }
      puts "You won!"
    elsif @player_ships.all? { |ship| ship.sunk? }
      puts "I won!"
    end
  end

  def generate_random_coordinates(length)
    rows = ('A'..'D').to_a
    columns = (1..4).to_a

    direction = ['horizontal', 'vertical'].sample
    coordinates = []

    if direction == 'horizontal'
      row = rows.sample
      start_column = rand(1..4 - length + 1)
      length.times { |i| coordinates << "#{row}#{start_column + i}" }
    else
      start_row = rand(0..(4 - length))
      column = columns.sample
      length.times { |i| coordinates << "#{rows[start_row + i]}#{column}" }
    end
    coordinates
  end
end

