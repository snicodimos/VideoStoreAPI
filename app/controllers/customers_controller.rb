class CustomersController < ApplicationController

  def index
    customers = Customer.all
    # sorting case sensitive, names must be capitalized
    if params[:n] && params[:p] && params[:sort]
      customers = Customer.paginate(:page => params[:p], :per_page => params[:n]).order(params['sort'])
    elsif params[:n] && params[:p]
      customers = Customer.paginate(:page => params[:p], :per_page => params[:n])
    else params[:sort]
      customers = Customer.order(params['sort'])
    end
    render json: jsonify(customers), status: :ok
  end

  private

  def jsonify(customer_data)
    return customer_data.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end
end
