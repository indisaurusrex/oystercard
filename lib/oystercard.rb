class Oystercard

  DEFAULT_START_BALANCE = 0
  attr_reader :balance

  def initialize
    @balance = DEFAULT_START_BALANCE
  end

  def top_up(credit)
    @balance += credit
  end

end
