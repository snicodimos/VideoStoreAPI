require "test_helper"

describe CustomersController do

  CUSTOMER_FIELDS = %w(id name registered_at postal_code phone).sort


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
end
