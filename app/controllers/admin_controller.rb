class AdminController < ApplicationController
    
  def index
    @users = User.all
    @movies = Movie.all
    @user = current_user
    user_has_movies = MovieWithUser.find_by(user_id: @current_user_id)

    render json: {
      user: @user,
      users: @users , 
      movies: @movies ,
      user_has_movies: user_has_movies,
      message: "user and movies record"
    } 
  end

def create

end



end
