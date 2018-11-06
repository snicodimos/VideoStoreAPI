require "test_helper"

describe Rental do
  before do
    @new_rental = Rental.new(customer: customers(:goeun), movie: movies(:titanic))
  end

  describe "validations" do

    it "is valid when all fields are present" do
      @new_rental.save
      @new_rental.valid?.must_equal true
    end

    it "is invalid with a missing customer id" do
      @new_rental.customer = nil
      @new_rental.save
      @new_rental.valid?.must_equal false
    end

    it "is invalid with a missing movie id" do
      @new_rental.movie = nil
      @new_rental.save
      @new_rental.valid?.must_equal false
    end

    it "is invalid with an invalid movie id" do
      @new_rental.movie_id = 1 #set to likely invalid movie id
      @new_rental.save
      @new_rental.valid?.must_equal false
    end
  end

  describe "relations" do
    it "belongs to a customer" do
      @new_rental.save
      customer = @new_rental.customer
      customer.must_be_instance_of Customer

      # customer = rentals(:one).customer
      # customer.must_be_instance_of Customer
    end

    it "belongs to a movie" do
      @new_rental.save
      movie = @new_rental.movie
      movie.must_be_instance_of Movie
    end


  end
end
