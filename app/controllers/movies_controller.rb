class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: jsonify_index(movies), status: :ok
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)

    if movie
      render json: jsonify_show(movie), status: :ok
    else
      render_error(:not_found, {id: ["Movie with id: #{movie_id} not found"]})
    end
  end

  def create

  end

  private

  def jsonify_index(movie_data)
    return movie_data.as_json(only: [:id, :title, :release_date])

  end
  def jsonify_show(movie_data)
    return movie_data.as_json(only: [:title, :overview, :release_date, :inventory])

  end

end
