require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # TODO: Your test code here!
      proc {
        Bank::SavingsAccount.new(1337, 9.99)
      }.must_raise ArgumentError
    end
  end # End of describe "#initialize"

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
      savings_account = Bank::SavingsAccount.new(1337, 200)
      new_balance = savings_account.withdraw(98)
      new_balance.must_equal 98 + 2, "$2 fee is not withdrawn from the savings account"
      savings_account.balance.must_equal 98 + 2, "$2 fee is not withdrawn from the savings account"
    end

    it "Outputs a warning if the balance would go below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 90.1
      savings_account = Bank::SavingsAccount.new(1337, start_balance)
      proc {
        savings_account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 91.0
      savings_account = Bank::SavingsAccount.new(1337, start_balance)
      updated_balance = savings_account.withdraw(withdrawal_amount)
      updated_balance.must_equal start_balance
      savings_account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 88.1
      savings_account = Bank::SavingsAccount.new(1337, start_balance)
      updated_balance = savings_account.withdraw(withdrawal_amount)
      updated_balance.must_equal start_balance
      savings_account.balance.must_equal start_balance
    end
  end # End of describe "#withdraw"

  describe "#add_interest" do
    it "Returns the interest calculated" do
      # TODO: Your test code here!
      savings_account = Bank::SavingsAccount.new(1337, 10000)
      savings_account.add_interest(0.25).must_equal 10000 * 0.25/100, "The method does not return the calculated interest"
    end

    it "Updates the balance with calculated interest" do
      # TODO: Your test code here!
      savings_account = Bank::SavingsAccount.new(1337, 10000)
      savings_account.add_interest(0.25)
      savings_account.balance.must_equal 10025, "The balance does not get updated"
    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
      savings_account = Bank::SavingsAccount.new(1337, 10000)
      proc {
        savings_account.add_interest(-0.25)
      }.must_raise ArgumentError
    end
  end # End of describe "#add_interest"
end # End of describe "SavingsAccount"
