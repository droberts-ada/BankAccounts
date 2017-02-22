module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end


    def withdraw(amount)
      # TODO: implement withdraw
      raise ArgumentError.new("MY COMMENT Withdrawal amount must be > 0") if amount < 0
      if amount > @balance
        print "The amount is bigger than your account balance"
      elsif amount <= @balance
        @balance -= amount
      end
      return @balance
    end


    def deposit(amount)
      # TODO: implement deposit
      raise ArgumentError.new("deposit amount must be >= 0") if amount < 0
      return @balance += amount
    end

  end
end
