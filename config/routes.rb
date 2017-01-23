Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
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
