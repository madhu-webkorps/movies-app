class SessionsController < Devise::SessionsController
    def create
      user = User.find_by_email(sign_in_params[:email])
  
      if user && user.valid_password?(sign_in_params[:password])
        @current_user = user
        render json: { message: "login successfully" ,
                       user: @current_user,
                     }, status: :ok
     
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    end
  end
  