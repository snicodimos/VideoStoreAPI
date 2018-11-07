class RentalsController < ApplicationController

  def checkout
    rental = Rental.new(rental_params)
    customer = Customer.find_by(id: rental_params[:customer_id])
    movie = Movie.find_by(id: rental_params[:movie_id])

    if movie.available_inventory > 0
      rental.due_date = Date.today + 7
      if rental.save
        checked_out = customer.movies_checked_out_count
        customer.update(movies_checked_out_count: checked_out +1)

        inventory = movie.available_inventory
        movie.update(available_inventory: inventory - 1)

        render json: {rental_id: rental.id}, status: :ok
      else
        render_error(:bad_request, rental.errors.messages)
      end
    else
      render_error(:forbidden, "No movie in available inventory.")
    end

  end

  def checkin
    # rental = Rental.find_by(rental_params)

    rental = Rental.find_by(customer_id: params[:customer_id], movie_id: params[:movie_id])

    if rental.nil?
      render_error(:not_found, {id: ["Rental info not found"]})
    else
      customer = Customer.find_by(id: rental.customer_id)
      movie = Movie.find_by(id: rental.movie_id)
      # update rental instance
      # change status to checkout=false
      rental.checkedout = false

      if rental.save
        # decrement the checked_out_count for customers

        checked_out = customer.movies_checked_out_count
        customer.update(movies_checked_out_count: checked_out -1)

        # increament the available_inventory of movies
        inventory = movie.available_inventory
        movie.update(available_inventory: inventory +1)

        render json: {rental_checkedout: rental.checkedout}, status: :ok
      else
        render_error(:bad_request, rental.errors.messages)

      end
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end


end
