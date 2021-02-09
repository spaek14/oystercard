class Oystercard

LIM = 90.0
MINFARE = 1.0

  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys, :journey

  def initialize
    @balance = 0.0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
    @journey = { entry:nil, exit:nil }
  end

  def top_up(money)
    raise "balance cannot exceed #{LIM}" if (@balance + money) > LIM
    @balance += money.to_f
  end

  def max_limit
    LIM
  end

  def in_journey?
    return false if @entry_station == nil
    return true
  end

  def touch_in(station)
    raise "cannot touch in if balance is less than #{MINFARE}" if @balance < MINFARE
    @entry_station = station
    @exit_station = nil
    @journey[:entry] = @entry_station
  end

  def touch_out(station)
    deduct(MINFARE)
    @entry_station = nil
    @exit_station = station
    @journey[:exit] = @exit_station
    @journeys << @journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
