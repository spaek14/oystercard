require 'oystercard'

describe Oystercard do

  it "has a balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "top_up adds appropriate amount" do
    expect(subject.top_up(5)).to eq(5)
  end

  it "has a maximum limit of 90" do
    expect(subject.max_limit).to eq(90)
  end

  it "balance + money cannot be greater than limit" do
    max_balance = Oystercard::LIM
    subject.top_up(max_balance)
    expect{ subject.top_up(1) }.to raise_error"balance cannot exceed #{max_balance}"
  end
end
