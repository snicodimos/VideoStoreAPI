class CustomersController < ApplicationController

  def index

    customers = Customer.all

    render json: jsonify(customers), status: :ok

  end

  private
  def jsonify(customer_data)
    return customer_data.as_json(only: [:id, :name, :registered_at, :postal_code, :phone])
  end
end
