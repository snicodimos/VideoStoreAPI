require "test_helper"

describe MoviesController do

  SHOW_FIELDS = %w(title overview release_date inventory available_inventory).sort
  INDEX_FIELDS = %w(id title release_date).sort


  describe "index" do
    it "is a real working route and returns JSON" do
      get movies_path

      body = check_response(expected_type: Array)
      expect(body.length).must_equal Movie.count

      body.each do |movie|
        expect(movie.keys.sort).must_equal INDEX_FIELDS
      end
    end

    it "returns an empty array where there are no movies" do
      Movie.destroy_all

      get movies_path
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe "show" do
    it "retrieves info on one movie" do
      get movie_path(movies(:titanic).id)
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal SHOW_FIELDS
    end

    it "returns 404 when the movie DNE" do
      movie = Movie.first
      movie.destroy
      get movie_path(movie)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
    end
  end

  describe "create" do

    before do
      @params = {
          "title": "Bohemian Rhapsody",
          "overview": "Bless Freddie Mercury",
          "release_date": Date.parse("2018-10-10"),
          "inventory": 2
      }
    end

    it "creates a new movie given valid data" do

      post movies_path(@params)
      body = check_response(expected_type: Hash)
      expect(body).must_include "id"
    end

    it "returns error for invalid data" do
      @params[:title] = nil
      post movies_path(@params)

      body = check_response(expected_status: :bad_request, expected_type: Hash)
      expect(body).must_include "errors"
    end

  end


  #
  # describe "create" do
  #   it "is a real working route" do
  #     # get movie_path(params)
  #     # must_respond_with :success
  #   end
end
