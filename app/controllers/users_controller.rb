class UsersController < ApplicationController
  load_and_authorize_resource
  
def index
  @users = User.all 
  authorize! :read, @users
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

  # all fav movies of user
  def fav_movies
   fav_movies = MovieWithUser.where(user_id: @current_user_id)
    unless fav_movies.blank?
      movie_names = []
      fav_movies.each do |f|
      movie_names.push(f.movie.name)
      end
    render json: {
      movies: movie_names
    }
    else
      render json: {msg: "you not have any favourite movie"}
    end
  end
 
 

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image)
  end

end