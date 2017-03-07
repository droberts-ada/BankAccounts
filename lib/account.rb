require 'csv'
module Bank
  class Account
    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date = "1999-03-27 11:30:09 -0800")
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
      @open_date = open_date
    end

    # a = Account.new
    # a.withdraw(20, 2, -10)

    def withdraw(amount, fee=0, min_balance=0)
      if amount < 0
        raise ArgumentError.new("withdrawal can't be negative number.")
      end

      if @balance - (amount + fee) < min_balance
        puts "Overdrawn"
        @balance
      else
        @balance -= amount + fee
      end
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new("withdrawal can't be negative number.")
      end
      @balance += amount
    end

    def self.all
      accounts = []
      CSV.open("./support/accounts.csv", "r").each do |line|
        accounts << self.new(line[0].to_i, line[1].to_f, line[2].to_s)
      end
      return accounts
    end

    def self.find(id)
      accounts = Account.all
      accounts.each do |account|
        if account.id == id
          return account
        end
      end
      raise ArgumentError.new('Account does not exist')
    end
  end
end
