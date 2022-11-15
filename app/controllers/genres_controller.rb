class GenresController < ApplicationController
    def index
      @genre = Genre.all.pluck(:id, :name)
      render json: {movie_categories: @genre , status: 200}
    end

    def create
        @genre = Genre.create(genre_params)
      if @genre.save!
        render json: {
          message: "category added successfully",
          category: @genre,
          status: 200
        }
      else
        render json: {message: @genre.errors}
      end
    end

  # permit params for genre
  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
