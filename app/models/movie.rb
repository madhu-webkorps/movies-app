class Movie < ApplicationRecord
    belongs_to :genre
    has_many :movie_with_users ,dependent: :destroy
    has_many :users, through: :movie_users 
    # has_many :genres
end
