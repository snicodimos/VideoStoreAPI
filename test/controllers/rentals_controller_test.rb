require "test_helper"

describe RentalsController do
  before do
    @params = {customer_id: customers(:goeun).id, movie_id: movies(:titanic).id}
  end

  describe "checkout" do
    it "creates an instance of Rental with valid data" do
      customer = customers(:goeun)
      movie = movies(:titanic)

      expect{
        post checkout_path, params: @params
      }.must_change "Rental.count", +1

      body = check_response(expected_type: Hash)
      expect(body).must_include "rental_id"
    end

    it "does not create Rental instance with invalid data" do
      @params[:customer_id] = nil

      expect{
        post checkout_path, params: @params
      }.wont_change "Rental.count"

      body = check_response(expected_status: :bad_request, expected_type: Hash)
      expect(body).must_include "errors"
    end

    it "returns error if no available movies to rent" do
      bad_params = {customer_id: customers(:goeun).id, movie_id: movies(:moana).id}

      expect{
        post checkout_path, params: bad_params
      }.wont_change "Rental.count"

      body = check_response(expected_status: :forbidden, expected_type: Hash)

      expect(body["errors"]).must_include "No movie in available inventory."
    end
  end

  describe "checkin" do
    it 'updates rental for valid request' do
      rental = rentals(:three)
      customer = rental.customer
      movie = rental.movie

      post checkin_path, params: {
        customer_id: rental.customer_id, movie_id: rental.movie_id
      }

      body = check_response(expected_type: Hash)
      expect(body).must_include "rental_checkedout"
    end


    it "returns error for rentals that do not exist" do
      @params[:customer_id] = nil
      @params[:movie_id] = nil

      post checkin_path, params: @params

      body = check_response(expected_status: :not_found, expected_type: Hash)
      expect(body).must_include "errors"
    end

  end
end
