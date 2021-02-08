class Oystercard

LIM = 90.0

  attr_reader :balance

  def initialize
    @balance = 0.0
  end

  def top_up(money)
    raise "balance cannot exceed #{LIM}" if (@balance + money) > LIM
    @balance += money.to_f
  end

  def max_limit
    LIM
  end

end
