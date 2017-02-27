require_relative "account"

module Bank
  class CheckingAccount < Account
    attr_accessor :check_count
    attr_reader :withdraw_fee, :check_withdraw_fee
    def initialize(id, balance, open_date = nil)
      super(id, balance, open_date)
      @withdraw_fee = 1
      @check_withdraw_fee = 2
      @check_count = 0
    end

    def withdraw(amount)
      amount += @withdraw_fee
      super(amount)
    end

    def withdraw_using_check(check_amount)
      raise ArgumentError.new("Note: The check amount must be positive") if check_amount < 0
      raise ArgumentError.new("Withdrawal denied. The balance will go pass the limit of -$10 ") if @balance - check_amount < -10
      @check_count += 1

      if @check_count <= 3
        @balance -= check_amount
      else
        raise ArgumentError.new("Withdrawal denied. The balance will go pass the limit of -$10 ") if @balance - (check_amount + @check_withdraw_fee) < -10
        @balance -= (check_amount + @check_withdraw_fee)
      end

      return @balance
    end

    def reset_checks
      @check_count = 0
    end

  end # End of the class CheckingAccount
end # End of the module Bank
