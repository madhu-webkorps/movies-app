class AdminController < ApplicationController
    
  def index
    @users = User.all
    @movies = Movie.all
    @user = current_user
     render json: {
      user: @user,
      users: @users , 
      movies: @movies ,
      message: "user and movies record"
    } 
  end
end
