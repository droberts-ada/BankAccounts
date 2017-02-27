require "csv" # one require files. Use file name without .rb

module Bank
  class Account
    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new("The balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @open_date = open_date
    end

    def self.all
      all_accounts = []
      CSV.open("./support/accounts.csv").each do |acc|
        all_accounts << self.new(acc[0].to_i, acc[1].to_f, acc[2]) # acc[2] should be transformed to date-time
      end
      return all_accounts
    end

    def self.find(id)
      found_account = nil
      self.all.each do |acc|
        if acc.id == id
          found_account = acc
          break
        end
      end
      raise ArgumentError.new "Account does not exist" if found_account == nil
      return found_account
    end

    def withdraw(amount)
      # TODO: implement withdraw
      raise ArgumentError.new("Withdrawal amount must be > 0") if amount < 0
      if amount > @balance
        print "Withdrawal denied. The amount is bigger than your account balance"
      elsif amount <= @balance
        @balance -= amount
      end
      return @balance
    end

    def deposit(amount)
      # TODO: implement deposit
      raise ArgumentError.new("Deposit amount must be >= 0") if amount < 0
      return @balance += amount
    end

  end # End of class Account
end # End of module Bank
