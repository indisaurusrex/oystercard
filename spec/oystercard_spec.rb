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
      expect {subject.top_up(100)}.to raise_error("Topup will exceed maximum balance, Topup not processed")
    end
  end

  # deduct is now private, so test commented out
  # describe '#deduct' do
  #   it 'deducts the fare from the balance' do
  #     subject.top_up(10)
  #     subject.deduct(2.40)
  #     expect(subject.balance).to eq(7.60)
  #   end
  # end

  describe '#in_journey' do
  let(:station) { double "station" }
    it 'responds with false if not in a journey' do
      expect(subject.in_journey).to eq(false)
    end

    it 'responds with true if in a journey' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey).to eq(true)
    end

    it 'responds with false if touched out from a journey' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.in_journey).to eq(false)
    end
  end

  describe '#touch_in' do
  let(:station) { double "station" }
    it 'responds to touch in' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end
    it 'raises error if less than £1 on card' do
      expect { subject.touch_in(station) }.to raise_error("Insufficient Funds")
    end
    it 'records the station when touched in' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
  let(:station) { double "station" }
    it 'responds to touch out' do
      expect(subject).to respond_to :touch_out
    end
    it 'deducts the minimum fare from the balance' do
      card = Oystercard.new(5)
      card.touch_in(station)
      expect { card.touch_out }.to change{ card.balance }.by(-1)
      # -1 will need to change if MINIMUM_FARE is altered
    end
    it 'removes the entry_station when touched out' do
      card = Oystercard.new(5)
      card.touch_in(station)
      card.touch_out
      expect(card.entry_station).to eq(nil)
    end


  end

end
