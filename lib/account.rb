module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new("withdrawal can't be negative number.")
      end
      if amount > @balance
        puts "Overdrawn"
        @balance
      else
        @balance -= amount
      end
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new("withdrawal can't be negative number.")
      end
      @balance += amount
    end
  end
end
