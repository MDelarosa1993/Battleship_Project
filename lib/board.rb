require './lib/cell'

class Board 

  attr_reader :cells

  def initialize
    @cells = {}
    create_cells
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
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false unless coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
    return false unless coordinates.length == ship.length

    letters = coordinates.map { |coordinate| coordinate[0] }
    numbers = coordinates.map { |coordinate| coordinate[1].to_i }

    consecutive_letters = (letters.first..letters.last).to_a
    consecutive_numbers = (numbers.first..numbers.last).to_a

    (letters.uniq.length == 1 && numbers == consecutive_numbers) ||
    (numbers.uniq.length == 1 && letters == consecutive_letters)
  end
end
  
