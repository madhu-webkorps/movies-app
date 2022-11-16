class MoviesController < ApplicationController
   authorize_resource only: [:create , :update, :destroy, :favorited, :un_favorited]
   before_action :set_movie, only: [:show, :update, :destroy]

  # list of all movies
    def index
        @movies = Movie.all
        render json: {
          movies: @movies
        }
    end

  # create method for movie
    def create
      @movie = Movie.create(movie_params)
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
                 data: arry
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

    # add to fav 
    def add_favourite
        @movie = Movie.find(params[:id])
        users = MovieWithUser.where(movie_id: @movie.id).pluck(:user_id)
        unless users.include?(@current_user_id) || users.count(@current_user_id) > 1
          @movie.favorited = true if @movie.favorited == false
          @movie.fav_count += 1
          @movie.save!
          
          MovieWithUser.create(movie_id: @movie.id , user_id: @current_user_id)
           users.blank? ? like_by_user = @current_user_id : like_by_user = users
          render json: {fav_count: @movie.fav_count , like_by_users: like_by_user}
        else
          render json: { msg: "you already add this movie to your fav list"}
        end
    end
      

    # permit params for movie
    private
    def movie_params
      params.require(:movie).permit(:name, :discription, :year, :director, :main_star, :favorited, :genre_id)
    end

end
