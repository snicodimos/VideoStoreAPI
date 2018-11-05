require "test_helper"

describe MoviesController do
  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "is a real working route" do
      # get movie_path()
      # must_respond_with :success
    end
  end

  describe "create" do
    it "is a real working route" do
      # get movie_path(params)
      # must_respond_with :success
    end
  end
end
