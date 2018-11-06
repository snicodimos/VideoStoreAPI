require "test_helper"

describe Rental do
  let(:rental) {rentals(:one)}

  describe "validations" do

    it "is valid when all fields are present" do
      rental.valid?.must_equal true
    end

    it "is invalid with a missing customer id" do
      rental.customer = nil
      rental.valid?.must_equal false
    end

    it "is invalid with a missing movie id" do
      rental.movie = nil
      rental.valid?.must_equal false
    end

    it "is invalid with an invalid movie id" do
      rental.movie_id = 1 #set to likely invalid movie id
      rental.valid?.must_equal false
    end
  end

  describe "relations" do
    it "belongs to a customer" do
      customer = rental.customer
      customer.must_be_instance_of Customer
    end

    it "belongs to a movie" do
      movie = rental.movie
      movie.must_be_instance_of Movie
    end

  end
end
