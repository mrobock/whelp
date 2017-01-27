Rails.application.routes.draw do

  resources :ratings do
    get 'get_rating'
    get 'rating_update'
  end
  get 'users/index'

  get 'users/show'

  post 'users/update'



  #generates /events/get_events route for calendar
  resources :events do
    get :get_events, on: :collection
  end

  resources :rsvps
  resources :event_reviews
  resources :venue_reviews
  resources :comments
  resources :events do
    get 'rating_update'
  end
  resources :venues do
    get 'map_location'
  end

  # Devise routes
  devise_for :users, controllers: { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }, path_prefix: 'my'
  resources :users

  root to: "welcome#index"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
