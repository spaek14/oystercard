require 'oystercard'

describe Oystercard do

  before(:each) do
    max_balance = Oystercard::LIM
    subject.top_up(max_balance)
  end


  it "has a balance of 0" do
    expect(Oystercard.new.balance).to eq(0)
  end

  it "top_up adds appropriate amount" do
    expect(Oystercard.new.top_up(5)).to eq(5)
  end

  it "has a maximum limit of 90" do
    expect(subject.max_limit).to eq(90)
  end

  it "balance + money cannot be greater than limit" do
    max_balance = Oystercard::LIM
    expect{ subject.top_up(1) }.to raise_error"balance cannot exceed #{max_balance}"
  end

  it "can deduct 5" do
    limit = Oystercard::LIM
    subject.deduct(5)
    expect(subject.balance).to eq(limit - 5)
  end

  it "new instance of Oystercard.in_journey?" do
    expect(subject.in_journey?).to eq(false)
  end

  it "can touch_in" do
    subject.touch_in
    expect(subject.in_journey?).to eq(true)
  end

  it "can touch_out" do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to eq(false)
  end

  it "can't touch_in if the balance is less than the minimum fare" do
    min_fare = Oystercard::MINFARE
    expect{ Oystercard.new.touch_in }.to raise_error"cannot touch in if balance is less than #{min_fare}"
  end
end
