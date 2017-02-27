require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end # End describe "#initialize"

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(1337, 200)
      withdrawal_amount = 99
      new_balance = checking_account.withdraw(withdrawal_amount)
      new_balance.must_equal withdrawal_amount + 1, "$1 fee is not withdrawn from the savings account"
      checking_account.balance.must_equal withdrawal_amount + 1, "$1 fee is not withdrawn from the savings account"
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = 200
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      updated_balance = checking_account.withdraw(withdrawal_amount)
      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      checking_account.balance.must_equal start_balance
    end
  end # End describe "#withdraw"

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # TODO: Your test code here!
      start_balance = 200
      check_amount = 25
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      reduced_balance = checking_account.withdraw_using_check(check_amount)
      reduced_balance.must_be :< ,start_balance , "The balance is not reduced"
    end

    it "Returns the modified balance" do
      # TODO: Your test code here!
      start_balance = 200
      check_amount = 25
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      new_balance = checking_account.withdraw_using_check(check_amount)
      new_balance.must_equal start_balance - check_amount, "A modified balance is not returned"
      checking_account.balance.must_equal new_balance, "The balance in the account is not the same as the return value of #withdraw_using_check"
    end

    it "Allows the balance to go down to -$10" do
      # TODO: Your test code here!
      start_balance = 200
      check_amount = 210
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      negative_balance = checking_account.withdraw_using_check(check_amount)
      negative_balance.must_be :>=, -10 , "The balance cannot go down to -$10"
    end

    it "Outputs a warning if the account would go below -$10" do
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(1337, 200)
      proc {
        checking_account.withdraw_using_check(210.1)
      }.must_raise ArgumentError
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = 210.1
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      proc {
        checking_account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
      checking_account.balance.must_equal start_balance, "The balance is not the same as start_balance"
    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = -1
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      proc {
        checking_account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = 10
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      3.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end
      checking_account.balance.must_equal (start_balance - 3 * withdrawal_amount) , "The resulting balance showsthat there is NOT 3 free uses"
    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = 10
      fee = 2
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      4.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end
      checking_account.balance.must_equal (start_balance - 4 * withdrawal_amount - fee) , "The resulting balance shows that the fee is not included"
    end

    it "Doesn't modify the balance if the account would go below -$10 due to the fee" do
      # TODO: Your test code here!
      start_balance = 30
      withdrawal_amount = 10
      checking_account = Bank::CheckingAccount.new(1337, start_balance)

      3.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end

      proc {
        checking_account.withdraw_using_check(9)
      }.must_raise ArgumentError
    end
  end # End describe "#withdraw_using_check"

  describe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(1337, 200)
      checking_account.reset_checks.must_equal 0, "Calling this method throws an error"
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = 10
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      2.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end
      checking_account.reset_checks
      3.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end
      checking_account.balance.must_equal (start_balance - 5 * withdrawal_amount) , "Does NOT make the next three checks free if less than 3 checks had been used"
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
      start_balance = 200
      withdrawal_amount = 10
      fee = 2
      checking_account = Bank::CheckingAccount.new(1337, start_balance)
      4.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end
      checking_account.reset_checks
      3.times do
        checking_account.withdraw_using_check(withdrawal_amount)
      end
      checking_account.balance.must_equal (start_balance - (4 * withdrawal_amount + fee) - 3 * withdrawal_amount) , "Does NOT
      make the next three checks free if more than 3 checks had been used"
    end

  end # End describe "#reset_checks"
end # END describe "CheckingAccount"
