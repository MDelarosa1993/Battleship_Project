class Cell 
attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !empty? && !@fired_upon
      @ship.hit
    end
    @fired_upon = true
  end

  def render(reveal = false) 
    if reveal && !empty?
      return "S"
    end
  end
end