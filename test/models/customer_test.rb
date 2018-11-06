require "test_helper"

describe Customer do
  describe "validations" do

    it "is valid when all fields are present" do
      semret = customers(:semret)
      semret.valid?.must_equal true
    end

    it "is invalid with a missing title" do
      semret = customers(:semret)
      semret.name = nil

      semret.valid?.must_equal false
    end

    it "is invalid with a missing registered date" do
      semret = customers(:semret)
      semret.registered_at = nil

      semret.valid?.must_equal false
    end

    it "is invalid with a missing address" do
      semret = customers(:semret)
      semret.address = nil

      semret.valid?.must_equal false
    end

    it "is invalid with a missing city" do
      semret = customers(:semret)
      semret.city = nil

      semret.valid?.must_equal false
    end

    it "is invalid with a missing state" do
      semret = customers(:semret)
      semret.state = nil

      semret.valid?.must_equal false
    end

    it "is invalid with a missing postal code" do
      semret = customers(:semret)
      semret.postal_code = nil

      semret.valid?.must_equal false
    end

    it "is invalid with a missing phone" do
      semret = customers(:semret)
      semret.phone = nil

      semret.valid?.must_equal false
    end
  end

  describe 'relationship' do
    it 'has many rentals' do
      customer = Customer.first
      customer.rentals.each do |rental|
        rental.must_be_instance_of Rental
      end
    end
  end
end
