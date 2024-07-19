class Ship 
attr_reader :name, :length, :health
  def initialize(name, length, health)
    @name = name
    @length = length
    @health = 3
  end
end