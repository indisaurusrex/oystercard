class Oystercard

  DEFAULT_START_BALANCE = 0
  MAXIMUM_BALANCE = 90
  BALANCE_ERROR = "Topup will exceed maximum balance of #{MAXIMUM_BALANCE}, Topup not processed"
  attr_reader :balance

  def initialize(balance = DEFAULT_START_BALANCE)
    @balance = balance
  end

  def top_up(credit)
    @balance + credit > MAXIMUM_BALANCE ? raise(BALANCE_ERROR) : @balance += credit
  end

  def deduct(fare)
    @balance -= fare
  end

end
