require './lib/cell'

class Board 

  attr_reader :cells

  def initialize
    @cells = {}
    create_cells
  end


  def valid_placement?(ship, coordinates)
    return false unless coordinates.length == ship.length
    return false unless consecutive?(coordinates)
    return false if diagonal?(coordinates)
    return false if overlapping?(coordinates)
    true
  end

  def create_cells
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  
  def consecutive_letters?(letters)
    letters.map(&:ord).each_cons(2).all? { |a, b| b == a + 1 }
  end

  def consecutive_numbers?(numbers)
    numbers.each_cons(2).all? { |a, b| b == a + 1 }
  end
  
  def consecutive?(coordinates)
    letters = coordinates.map { |coord| coord[0] }
    numbers = coordinates.map { |coord| coord[1..-1].to_i }

    same_letters = letters.uniq.size == 1
    same_numbers = numbers.uniq.size == 1

    if same_letters
      return consecutive_numbers?(numbers)
    elsif same_numbers
      return consecutive_letters?(letters)
    else
      return false
    end
  end

  def diagonal?(coordinates)
    letters = coordinates.map { |coord| coord[0].ord }
    numbers = coordinates.map { |coord| coord[1..-1].to_i }
  
    diagonal_letters = letters.each_cons(2).all? { |a, b| (b - a).abs == 1 }
    diagonal_numbers = numbers.each_cons(2).all? { |a, b| (b - a).abs == 1 }
  
    diagonal_letters && diagonal_numbers
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      cells[coordinate].place_ship(ship)
    end
  end

  def overlapping?(coordinates)
    coordinates.any? { |coord| @cells[coord].ship }
  end

  def render(reveal = false)
    board_display = "  1 2 3 4 \n"

    ("A".."D").each do |letter|
      row = "#{letter} "
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        row += @cells[coordinate].render(reveal) + " "
      end
      board_display += row + "\n"
    end

    board_display
  end

end

  
