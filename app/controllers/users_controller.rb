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

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image)
  end

end