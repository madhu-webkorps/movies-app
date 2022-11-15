class UsersController < ApplicationController

def index
  @users = User.all 

  render json: { users: @users , 
                 total_users: @users.count
               }
end

def show
  @user = User.find(params[:id]) 
  if @user.user?
     render json: {message: "access denied" }
  else
    render json: {user: @user , status: 200 }
  end
end


  def update
    user = User.where(id: params[:id]).first
    if user.update(user_params)
      render json: user, status:200
    else
      render json: user.errors , status:422
    end
  end

  # add movie to favourite
 
 def add_favourite
  @movie.favorited = true if @movie.favorited == false
  @movie.fav_count += 1
  @movie.save!
  MovieWithUser.create(movie: @movie.id , user: @current_user_id)
  users = MovieWithUser.where(movie_id: @movie.id).pluck(:user_id)
  render json: {fav_count: @movie.fav_count , like_by_users: users}
end
  

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image)
  end

end