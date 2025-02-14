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
    @fired_upon = true
    if @ship
      @ship.hit 
      return "a hit" if !@ship.sunk?
      return "a hit! The ship is sunk" if @ship.sunk?
    else
      return "a miss"
    end
  end

  def render(reveal = false)
    return "X" if @ship&.sunk?
    return "H" if @fired_upon && !@ship.nil?
    return "M" if @fired_upon && @ship.nil?
    return "S" if reveal && !@fired_upon && !@ship.nil?
    return "." if !@fired_upon
    # if reveal && !empty?
    #   return "S"
    # end
    # if !fired_upon?
    #   return "."
    # end
    # if fired_upon && empty?
    #   return "M"
    # end
    # if fired_upon? && !empty? && !@ship.sunk?
    #   return "H"
    # end
    # if fired_upon? && !empty? && @ship.sunk?
    #   return "X"
    # end
  end
end