require "test_helper"

describe Rental do
  describe "validations" do
    before do
      @new_rental = Rental.new(customer: customers(:goeun), movie: movies(:titanic))
    end

    it "is valid when all fields are present" do
      @new_rental.save
      @new_rental.valid?.must_equal true
    end

    it "is invalid with a missing customer id" do
      @new_rental.customer = nil
      @new_rental.valid?.must_equal false
    end

    it "is invalid with a missing movie id" do
      @new_rental.movie = nil
      @new_rental.valid?.must_equal false
    end

    it "is invalid with an invalid movie id" do
      @new_rental.movie_id = 1 #set to likely invalid movie id
      @new_rental.valid?.must_equal false
    end
  end

  describe "relations" do


  end
end
