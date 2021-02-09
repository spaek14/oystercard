class Oystercard

LIM = 90.0
MINFARE = 1.0

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0.0
    @in_journey = false
  end

  def top_up(money)
    raise "balance cannot exceed #{LIM}" if (@balance + money) > LIM
    @balance += money.to_f
  end

  def max_limit
    LIM
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "cannot touch in if balance is less than #{MINFARE}" if @balance < MINFARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
