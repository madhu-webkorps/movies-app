class MoviesController < ApplicationController
   
  before_action :set_book, only: [:show, :update, :destroy]

  # list of all movies
    def index
        @movies = Movie.all
    end

  # create method for movie
    def create
     
      @movie = Movie.create(movie_params)
      debugger
      if @movie.save!
        render json: {
          movie: @movie ,
          category: @movie.genre.name,
          message: "movie was added sucessfully!" ,
          status: 200
        }
      else
        render  @movie.errors
      end
      @movie.fav_count += 1 if @movie.favorited 
    end
    
    # list of  all favrioted movies
    def favorited
      fav_movies =  Movie.where(favorited: true)
      arry = []
      fav_movies.each do |f|
          hash = {:id => f.id, :name => f.name, :favorited => f.fav_count}
          arry.push(hash)
       end 
        render json: {
                  data:arry
        }               
    end


    # list of  all Un favrioted movies
    def un_favorited
      fav_movies =  Movie.where(favorited: false).all
      render json: {un_fav_movies: fav_movies}
    end

   

    # DELETE /books/1
    def destroy
      if @movie.destroy
        render json: {"message" => "movie deleted successfully with id: #{@movie.id}, name: #{@movie.name} "}
      else
       render json: {"message" =>"movie is not deleted"}
      end
    end

    # show movie

    def show
      render json: @movie , status: 200
    end

    # PATCH/PUT /movies/1
    def update
      debugger
      if @movie.update(movie_params)
        render json: { "message" => "movie updated successfully", "movie" => @movie}
      else
        render json: @movie.errors
      end
    end

    # set movie
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # permit params for movie
    private
    def movie_params
      params.require(:movie).permit(:name, :discription, :year, :director, :main_star, :favorited, :genre_id)
    end

end
