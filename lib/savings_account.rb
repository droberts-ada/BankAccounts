require_relative "account"

module Bank
  class SavingsAccount < Account
    attr_accessor :fee
    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new("The balance must be >= $10") if balance < 10.0
      super(id, balance, open_date)
      @withdraw_fee = 2
    end

    def withdraw(amount)
      raise ArgumentError.new("Withdrawal amount must be > 0") if amount < 0
      if amount + @withdraw_fee > @balance - 10
        print "Withdrawal denied. Your balance would go below $10"
      else
        @balance -= amount + @withdraw_fee
      end
      return @balance
    end

    def add_interest(rate)
      raise ArgumentError.new("Note: The rate must be positive") if rate < 0
      interest = @balance * rate/100
      @balance += interest
      return interest
    end

  end # End of class SavingsAccount
end # End of module Bank
