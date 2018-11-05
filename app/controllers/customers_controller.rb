class CustomersController < ApplicationController

  def index

    customers = Customer.all

    render json: jsonify(customers), status: :ok

  end

  private
  def jsonify(customer_data)
    return customer_data.as_json(only: [:name, :registered_at, :address, :city, :state, :postal_code, :phone])
  end
end
