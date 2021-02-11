require 'journey'
require 'oystercard'

describe Journey do

min_fare = Journey::MINFARE
penalty_fare = Journey::PENFARE

let(:station) {double :station}

  it "starts" do
    subject.start(station)
    expect(subject.entry_station).to eq(station)
  end

  it "ends" do
    subject.end(station)
    expect(subject.exit_station).to eq(station)
  end

  it "correctly charges minimum fare for complete journey" do
    subject.start(station)
    subject.end(station)
    expect(subject.fare).to eq(min_fare)
  end

  it "charges penalty when no entry station but exit station" do
    subject.end(station)
    expect(subject.fare).to eq(penalty_fare)
  end

  it "charges penalty when no exit station but entry station" do
    subject.start(station)
    expect(subject.fare).to eq(penalty_fare)
  end

  it "is complete?" do
    subject.start(station)
    subject.end(station)
    expect(subject.complete?).to eq(true)
  end

end
