class RentalsController < ApplicationController

  def checkout
    # creating a new instance of a rental
    rental = Rental.new(rental_params)

    # while we check if the avaiable inventory of the movie is not 0
    movie = Movie.find_by(id: rental_params[:movie_id])

    if movie.available_inventory > 0
      rental.due_date = Date.today + 7
      if rental.save
        render json: {rental_id: rental.id}
      else
        render_error(:bad_request, rental.errors.messages)
      end
    else
      render_error(:forbidden, "No movie in available inventory.")
    end


    # set the due date (this is a model logic) that will be called here
    # customer checked_out_count will be increamented (model methods)
    # available_inventory will be decremented (model test)
  end

  def checkin
    # update rental instance
    # change status to checkout=false
    # decrement the checked_out_count for customers
    # increament the available_inventory of movies

  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
  end


end
