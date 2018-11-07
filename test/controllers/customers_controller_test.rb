require "test_helper"

describe CustomersController do

  CUSTOMER_FIELDS = %w(id name registered_at postal_code phone movies_checked_out_count).sort

  describe "index" do
    it "is a real working route" do
      get customers_path
      must_respond_with :success

      body = check_response(expected_type: Array)
      expect(body.length).must_equal Customer.count

      body.each do |customer|
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end

    it 'returns an empty array when there are no customers' do
      Customer.destroy_all

      get customers_path

      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe "query parameters" do
    it 'should sort by name' do
      get customers_path, params: {sort: 'name'}

      body = check_response(expected_type: Array)
      expect(body[0]['name']).must_equal "Amanda"
    end

    it "gives pagination and number of responses query" do
      get customers_path, params: {sort: 'name', n: 1, p: 3}

      body = check_response(expected_type: Array)
      expect(body[0]['name']).must_equal "Samantha"
    end
  end


end
