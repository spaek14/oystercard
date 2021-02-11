require 'oystercard'
require 'journey'

describe Oystercard do

  before(:each) do
    max_balance = Oystercard::LIM
    subject.top_up(max_balance)
  end

  let(:station) {double :station}
  let(:station2) {double :station}

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

  # it "new instance of Oystercard.in_journey?" do
  #   expect(subject.in_journey?).to eq(false)
  # end

  # it "can touch_in" do
  #   subject.touch_in(station)
  #   expect(subject.in_journey?).to eq(true)
  # end

  it "can touch_out" do
    # subject.touch_in(station)

    expect{ subject.touch_out(station) }.to change{ subject.journeys.length }.by 1
  end

  it "can't touch_in if the balance is less than the minimum fare" do
    min_fare = Oystercard::MINFARE
    expect{ Oystercard.new.touch_in(station) }.to raise_error"cannot touch in if balance is less than #{min_fare}"
  end

  it "should deduct minimum fare when touch_out is called on complete journey" do
    min_fare = Oystercard::MINFARE
    subject.touch_in(station)
    expect {subject.touch_out(station)}.to change {subject.balance}.by(-min_fare)
  end

  it "touch_in records entry station" do
    subject.touch_in(station)
    expect(subject.journey.entry_station).to eq station
  end

  it "touch_out sets entry station to nil" do
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
  end

  it "touch_out sets exit_station to station" do
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.journeys[-1].exit_station).to eq station
  end

  it "touch_in sets exit_station to nil" do
    subject.touch_in(station)
    subject.touch_out(station)
    subject.touch_in(station)
    expect(subject.exit_station).to eq nil
  end

  it "touch_in and touch_out creates a journey" do
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journey.entry_station).to eq(nil)
    expect(subject.journey.exit_station).to eq(nil)
  end

  it "updates list of journeys" do
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journeys.last.entry_station).to eq(station)
    expect(subject.journeys.last.exit_station).to eq(station2)
  end

  it "empty list of journeys for new card" do
    expect(Oystercard.new.journeys).to eq([])
  end

end
