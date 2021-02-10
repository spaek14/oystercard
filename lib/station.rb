class Station

attr_reader :zone, :name

  def initialize
    @name = "Camden Town"
    @zone = 1
  end

  def name
    @name
  end

  def zone
    @zone
  end
end
