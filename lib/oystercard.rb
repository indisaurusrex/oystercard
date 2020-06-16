class Oystercard

  DEFAULT_START_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE_ERROR = "Topup will exceed maximum balance, Topup not processed"
  MINIMUM_BALANCE_ERROR = "Insufficient Funds"
  attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_START_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(credit)
    @balance + credit > MAXIMUM_BALANCE ? raise(MAXIMUM_BALANCE_ERROR) : @balance += credit
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail MINIMUM_BALANCE_ERROR if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
