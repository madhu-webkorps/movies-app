class RegistrationsController < Devise::RegistrationsController
    
  def create
        @user = User.new(sign_up_params)
        if @user.save
          token = @user.generate_jwt
          render json: { message: 'Signed up sucessfully.',
                        user: @user,
                        token: token
                        }  
        else
          render json: { errors: "#{@user.errors.full_messages}"}, status: :unprocessable_entity
        end
      end 

    def sign_up_params
      params.require(:user).permit(:email, :password, :role, :password_confirmation, :username)
    end

  end