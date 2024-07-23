class Game 
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
  end

  def setup
    puts "Setting up th egame"
    # place_computer_ships
    place_player_ships
  end

  # def place_computer_ships
  #   @computer_ships.each do |ship|
  #     placed = false
  #     until placed
  #       coodinates = generate_random_coordinates(ship.length)
  #       if @computer_board.valid_placement?(ship, coordinates)
  #         @computer_board.place(ship, coordinates)
  #         placed = true
  #       end
  #     end
  #   end
  # end

  # def generate_random_coordinates(length)
    
  # end

  def place_player_ships
    @player_ships.each do |ship|
      valid_placement  = false
      until valid_placement
        puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
        coordinates = gets.chomp.split
        if @player_board.valid_placement?(ship, coordinates)
          @player_board.place(ship, coordinates)
          valid_placement = true
          display_board(@player_board)
        else
          puts "Those are invalid coordinates. Please try again."
        end
      end
    end
  end

  def display_board(board)
    puts " 1 2 3 4"
    ('A'..'D').each do |letter|
      print "#{letter} "
      (1..4).each do |number|
        cell = board.cells["#{letter}#{number}"]
        print cell.empty? ? ". " : "S "
      end
      puts
    end
  end

  def start
    puts "Game started!"
  end
end