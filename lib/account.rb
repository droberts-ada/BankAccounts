require "csv"

module Bank
  class Account
    attr_reader :id, :balance
    def initialize(id, balance)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end

    def self.all
      @all_accounts = []
      CSV.open("./support/accounts.csv").each do |acc|
        @all_accounts << self.new(acc[0].to_i, acc[1].to_f)
      end
      return @all_accounts
    end


    def self.find(id)
      all_accounts = self.all
      to_be_returned = nil
      all_accounts.each do |acc|
        if acc.id == id
          to_be_returned = acc
        end
      end
      raise ArgumentError.new "Account does not exist" if to_be_returned == nil
      return to_be_returned
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
