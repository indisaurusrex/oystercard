class Oystercard

  DEFAULT_START_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE_ERROR = "Topup will exceed maximum balance, Topup not processed"
  MINIMUM_FARE_ERROR = "Insufficient Funds"
  attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_START_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(credit)
    @balance + credit > MAXIMUM_BALANCE ? raise(MAXIMUM_BALANCE_ERROR) : @balance += credit
  end

  def touch_in
    fail MINIMUM_FARE_ERROR if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out(fare = MINIMUM_FARE)
    @in_journey = false
    deduct(fare)
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
