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

  describe "rent_movie" do
    it "+1 checked_out_count and -1 available_inventory" do
      customer = rental.customer
      movie = rental.movie

      pre_inventory = movie.available_inventory
      pre_movie_count = customer.movies_checked_out_count

      rental.rent_movie(customer, movie)

      expect(movie.available_inventory).must_equal pre_inventory -1
      expect(customer.movies_checked_out_count).must_equal pre_movie_count +1
    end
  end

  describe "return_movie" do
    it "-1 checked_out_count and +1 available_inventory" do
      customer = rental.customer
      movie = rental.movie

      pre_inventory = movie.available_inventory
      pre_movie_count = customer.movies_checked_out_count

      rental.return_movie(customer, movie)

      expect(movie.available_inventory).must_equal pre_inventory +1
      expect(customer.movies_checked_out_count).must_equal pre_movie_count -1
    end
  end


end
