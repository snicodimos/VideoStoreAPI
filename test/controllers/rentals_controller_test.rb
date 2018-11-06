require "test_helper"

describe RentalsController do

  describe "checkout" do
    before do
      @params = {customer_id: customers(:goeun).id, movie_id: movies(:titanic).id}
    end

    it "creates an instance of Rental with valid data" do
      customer = customers(:goeun)
      movie = movies(:titanic)

      pre_inventory = movie.available_inventory
      pre_movie_count = customer.movies_checked_out_count

      expect{
        post checkout_path(@params)
      }.must_change "Rental.count", +1

      customer.reload
      movie.reload

      expect(movie.available_inventory).must_equal pre_inventory -1

      expect(customer.movies_checked_out_count).must_equal pre_movie_count +1

      body = check_response(expected_type: Hash)
      expect(body).must_include "rental_id"
    end

    it "does not create Rental instance with invalid data" do
      @params[:customer_id] = nil

      expect{
        post checkout_path(@params)
      }.wont_change "Rental.count"

      body = check_response(expected_status: :bad_request, expected_type: Hash)
      expect(body).must_include "errors"
    end

    it "returns error if no available movies to rent" do
      bad_params = {customer_id: customers(:goeun).id, movie_id: movies(:moana).id}

      expect{
        post checkout_path(bad_params)
      }.wont_change "Rental.count"

      body = check_response(expected_status: :forbidden, expected_type: Hash)

      expect(body["errors"]).must_include "No movie in available inventory."
    end


  end

  describe "checkin" do
  end
end
