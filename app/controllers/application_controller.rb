class ApplicationController < ActionController::API
  respond_to :json
  
  SECRET = Rails.application.secrets.secret_key_base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

    def authenticate_user
      if request.headers['Authorization'].present?
        begin
          jwt_payload = decode_user_data(request.headers['Authorization']).first
          @current_user_id = jwt_payload['id']
          @current_user = User.find(@current_user_id)
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
                  head :unauthorized
        end
      end
    end

    # decode token 
    def decode_user_data(token)
      begin
        data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
        return data
      rescue => e
        puts e
      end
    end

    def authenticate_user!(options = {})
      head :unauthorized unless signed_in?
    end
  
    def current_user
      @current_user ||= super || User.find(@current_user_id)
    end
  
    def signed_in?
      @current_user_id.present?
    end
end
