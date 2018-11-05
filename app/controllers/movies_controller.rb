class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: jsonify(movies), status: :ok
  end

  def show
  end

  def create
  end

  private

  def jsonify(movie_data)
    return movie_data.as_json(only: [:title, :overview, :release_date, :inventory])

  end

end
