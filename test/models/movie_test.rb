require "test_helper"

describe Movie do
  describe "validations" do

    it "is valid when all fields are present" do
      titanic = movies(:titanic)
      titanic.valid?.must_equal true
    end

    it "is invalid with a missing title" do
      titanic = movies(:titanic)
      titanic.title = nil

      titanic.valid?.must_equal false
    end

    it "does not create movie with existing title" do
      titanic = movies(:titanic)
      new_movie = movies(:notebook)

      new_movie.title = titanic.title
      new_movie.valid?.must_equal false
    end

    it "is invalid with a missing overview" do
      titanic = movies(:titanic)
      titanic.overview = nil
      titanic.valid?.must_equal false
    end

    it "is invalid with a missing release date" do
      titanic = movies(:titanic)
      titanic.release_date = nil
      titanic.valid?.must_equal false
    end

    it "is invalid with a missing inventory" do
      titanic = movies(:titanic)
      titanic.inventory = nil
      titanic.valid?.must_equal false
    end
  end

  describe 'relationship' do
    it 'has many rentals' do
      movie = Movie.first
      movie.rentals.each do |rental|
        rental.must_be_instance_of Rental
      end
    end
  end
end
