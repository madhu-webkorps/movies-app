class Movie < ApplicationRecord
    belongs_to :genre
    has_many :movie_with_users ,dependent: :destroy
    has_many :users, through: :movie_users 
    # has_many :genres

# validations
 validates   :name, presence: true, 
             length:{ maximum: 80 }

 year  format: { with: /\A\d{4}\z/ ,
      message: "only allows digits" }

 director    length: { maximum: 60 }

 main_star    length:  { maximum: 60 }
 
 discription  length:  { maximum: 400 }
end
