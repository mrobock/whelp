Rails.application.routes.draw do

  get 'users/index'

  get 'users/show'

  post 'users/update'



  #generates /events/get_events route for calendar
  resources :events do
    get :get_events, on: :collection
  end

  post '/rate' => 'rater#create', :as => 'rate'
  resources :rsvps
  resources :event_reviews
  resources :venue_reviews
  resources :comments
  resources :events
  resources :venues do
    get 'map_location'
  end

  # Devise routes
  devise_for :users, path_prefix: 'my', controllers: { registrations: 'registrations' }
  resources :users

  get 'welcome/index'
  root 'welcome#index'
  root to: "welcome#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
