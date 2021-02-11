class Journey

MINFARE = 1.0
PENFARE = 6.0

attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
      @entry_station = station
  end

  def end(station)
      @exit_station = station
  end

  def fare
    return PENFARE if !complete?
    return MINFARE
  end

  def complete?
    return false if (@entry_station == nil && @exit_station != nil) || (@entry_station != nil && @exit_station == nil)
    return true
  end

end
