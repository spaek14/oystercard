require './lib/journey'

class Oystercard

LIM = 90.0
MINFARE = 1.0

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey

  def initialize
    @balance = 0.0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(money)
    raise "balance cannot exceed #{LIM}" if (@balance + money) > LIM
    @balance += money.to_f
  end

  def max_limit
    LIM
  end

  def touch_in(station)
    raise "cannot touch in if balance is less than #{MINFARE}" if @balance < MINFARE
    complete_journey if !@journey.complete?
    @journey.start(station)
  end

  def touch_out(station)
    @journey.end(station)
    complete_journey
  end

  private

  def complete_journey
    deduct(@journey.fare)
    @journeys << @journey
    @journey = Journey.new
  end

  def deduct(fare)
    @balance -= fare
  end

end
