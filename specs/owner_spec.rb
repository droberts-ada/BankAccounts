

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'


###########
# OPTIONAL
###########

describe "Owner class" do
  describe "Owner#initialize" do
    it "Takes an ID, last name, first name, street address, city and state" do
      id = 18
      last_name = "Gonzalez"
      first_name = "Laura"
      street_address = "310 Hauk Street"
      city = "Springfield"
      state = "Illinois"

      owner = Bank::Owner.new(id, last_name, first_name, street_address, city, state)

      owner.must_respond_to :id
      owner.id.must_equal id

      owner.must_respond_to :last_name
      owner.last_name.must_equal last_name

      owner.must_respond_to :first_name
      owner.first_name.must_equal first_name

      owner.must_respond_to :street_address
      owner.street_address.must_equal street_address

      owner.must_respond_to :city
      owner.city.must_equal city

      owner.must_respond_to :state
      owner.state.must_equal state
    end
  end
end
