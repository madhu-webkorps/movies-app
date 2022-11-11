class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_initialize :set_default_role, :if => :new_record?       
    enum role: [:user , :admin]

  def set_default_role
    self.role ||= :user
  end

  def generate_jwt
    JWT.encode({ id: id,
                exp: 5.days.from_now.to_i },
                Rails.application.secrets.secret_key_base)
  end

end
