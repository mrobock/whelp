Rails.application.routes.draw do

  #generates /events/get_events route for calendar
  resources :events do
    get :get_events, on: :collection
  end

  resources :event_reviews
  resources :venue_reviews
  resources :comments
  resources :events
  resources :venues
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  root to: "welcome#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
