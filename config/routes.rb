Rails.application.routes.draw do
  # scope :api, defaults: { format: :json } do
  # devise_for :users, controllers: { 
  #   registrations: "registrations",
  #   sessions: "sessions"
  #   }

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions ,
                                       registrations: :registrations},
                       path_names: { sign_in: :login }
    end

  resources :users
  resources :admin
  resources :movies
  resources :genres

  post 'add_favourite/:id', to: "users#add_favourite"
 get 'favorited_movies', to: "movies#favorited"
  
end
