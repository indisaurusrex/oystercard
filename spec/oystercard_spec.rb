require 'oystercard'

describe Oystercard do

  describe '#initialize' do
    it 'can override the default balance when creating a new card' do
      card = Oystercard.new(40)
      expect(card.balance).to eq(40)
    end
  end 

  describe '@balance' do
    it 'initializes a new card with a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'adds the specified credit to the balance' do
      subject.top_up(9)
      expect(subject.balance).to eq(9)
    end
    it 'will raise an exception when a topup will exceed the maximum value of 90' do #starting with 90 but could be removed to make test better
      expect {subject.top_up(100)}.to raise_error("Topup will exceed maximum balance of 90, Topup not processed")
    end
  end

  describe '#deduct' do
    it 'deducts the fare from the balance' do
      subject.top_up(10)
      subject.deduct(2.40)
      expect(subject.balance).to eq(7.60)
    end
  end

end
