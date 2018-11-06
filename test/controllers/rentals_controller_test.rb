require "test_helper"

describe RentalsController do

  describe "checkout" do
    before do
      @params = {customer_id: customers(:goeun).id, movie_id: movies(:titanic).id}
    end

    it "creates an instance of Rental with valid data" do
      expect{
        post checkout_path(@params)
      }.must_change "Rental.count", +1

      body = check_response(expected_type: Hash)
      expect(body).must_include "rental_id"
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
