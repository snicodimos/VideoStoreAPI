class CustomersController < ApplicationController

  def index
    customers = Customer.all
    # sorting case sensitive, names must be capitalized
    if params[:sort]
      customers = Customer.order(params['sort'])
    end

    if params[:n] && params[:p]
      customers = customers.paginate(:page => params[:p], :per_page => params[:n])


      # render json: posts, meta: pagination_meta(posts), include: ['user']
    end
    paginate json: jsonify(customers), status: :ok
  end


  private

  def jsonify(customer_data)
    return customer_data.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end
end
