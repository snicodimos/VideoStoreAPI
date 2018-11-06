class RentalsController < ApplicationController

  def checkout
    # creating a new instance of a rental
    # while we check if the avaiable inventory of the movie is not 0
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



end
